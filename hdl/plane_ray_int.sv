import apu_core_package::*;
import riscv_defines::*;
import fpnew_pkg::*;
import plane_ray_int_defines::*;

module plane_ray_int
#(
    parameter FP_DIVSQRT = 1,
    parameter NUM_FMAS = 6,
    parameter NUM_FPRTI_REGS = 16,
    parameter TAG_W = $bits(tag_t)
)
(
    input  logic                     clk,
    input  logic                     rst_n,

    input  logic [31:0]              fprti_regs_i [NUM_FPRTI_REGS],
    input  logic                     input_valid_i,
    
    output logic [31:0]              return_o,
    output logic                     output_valid_o
);

localparam NUM_DIMENSIONS = 3;

//Sample inputs with local registers (unkown if CPU will hold them throughout computation)
logic [31:0] p0 [NUM_DIMENSIONS];
logic [31:0] p1 [NUM_DIMENSIONS];
logic [31:0] p2 [NUM_DIMENSIONS];
logic [31:0] r0 [NUM_DIMENSIONS];
logic [31:0] rd [NUM_DIMENSIONS];

always_ff @(posedge clk) begin
    if (!rst_n) begin
        for (int i = 0; i < 3; i++) begin
            p0[i] <= '0;
            p1[i] <= '0;
            p2[i] <= '0;
            r0[i] <= '0;
            rd[i] <= '0;
        end
    end else if (input_valid_i) begin
        p0[0] <= fprti_regs_i[0]; p0[1] <= fprti_regs_i[1]; p0[2] <= fprti_regs_i[2];
        p1[0] <= fprti_regs_i[3]; p1[1] <= fprti_regs_i[4]; p1[2] <= fprti_regs_i[5];
        p2[0] <= fprti_regs_i[6]; p2[1] <= fprti_regs_i[7]; p2[2] <= fprti_regs_i[8];
        r0[0] <= fprti_regs_i[9]; r0[1] <= fprti_regs_i[10]; r0[2] <= fprti_regs_i[11];
        rd[0] <= fprti_regs_i[12]; rd[1] <= fprti_regs_i[13]; rd[2] <= fprti_regs_i[14];
    end
end

typedef enum logic [3:0] {
    IDLE,
                        // All vector subtractions that do NOT depend on n
    PREP_VDIFF_1,
    PREP_VDIFF_2,     //   – AB,  AC,  P-R0                       ( ≤12 adds, break into 2 stages?)     

    MAKE_NORMAL,      // n = AB × AC                              ( 6 mul + 3 add )

    PLANE_DOTS,       // (P-R0)·n  ||  R_d·n                      ( 6 mul + 4 add )

    DIV_T,            // t = num/den                              ( 1 div )

    INTERSECTION,     // P' = trd + r0                            ()

    TRI_CROSS1,       // a1 = (P2-P0) × n                         ( 6 mul + 3 add )
    TRI_CROSS2,       // a2 = (P1-P0) × n                         ( 6 mul + 3 add )

    TRI_DOTS,         // den1 = a1·(P1-P0) || den2 = a2·(P2-P0)   ( 6 mul + 4 add )

    DIV_E0,           // e1.x  e2.x  t  (3 divs – first wave)
    DIV_E1,           // e1.y  e2.y       (3 divs – second wave)
    DIV_E2,           // e1.z  e2.z       (1–3 divs, last wave)

    BARY_DOTS,        // b1, b2  (two dot products)               ( 6 mul + 4 add )

    BARY_FIN          // b0 = 1 - b1 - b2  (+ inside-triangle test)
} plane_ray_state_t;

plane_ray_state_t state, next_state;

logic [31:0] srcA_i [NUM_FMAS];
logic [31:0] srcB_i [NUM_FMAS];
logic [31:0] srcC_i [NUM_FMAS];

logic fma_in_ready[NUM_FMAS];
logic div_in_ready;
logic fma_in_valid[NUM_FMAS];
logic div_in_valid;
logic fma_out_valid[NUM_FMAS];
logic div_out_valid;

logic fma_op[NUM_FMAS];
logic fma_mod[NUM_FMAS];

logic [31:0] fma_results[NUM_FMAS];

logic [31:0] normal_vector          [NUM_DIMENSIONS];
logic [31:0] numerator_reg, denominator_reg;
logic [31:0] t_reg;
logic [31:0] intersection_pt        [NUM_DIMENSIONS];
logic [31:0] intermediate_vector1   [NUM_DIMENSIONS];
logic [31:0] intermediate_vector2   [NUM_DIMENSIONS]; 

logic [31:0] AB   [NUM_DIMENSIONS];
logic [31:0] AC   [NUM_DIMENSIONS];
logic [31:0] PR   [NUM_DIMENSIONS]; 

logic proceed;
logic fma_inflight[NUM_FMAS];
logic fma_inflight_next[NUM_FMAS];


always_ff @(posedge clk) begin : transition_exec_save_outs
    if(!rst_n) begin
        state <= IDLE;
        for(int i = 0; i < NUM_DIMENSIONS; i++) begin
            AB[i] <= '0;
            AC[i] <= '0;
            PR[i] <= '0;
            normal_vector[i] <= '0;
        end
        numerator_reg <= '0;
        denominator_reg <= '0;
        t_reg <= '0;

        for (int i = 0; i < NUM_FMAS; i++) fma_inflight[i] <= 1'b0;

    end else begin
        state <= next_state;
        
        unique case (state)
            //calculate AB, AC
            PREP_VDIFF_1: begin
                for(int i = 0; i < NUM_FMAS; i++) begin
                    if(fma_out_valid[i]) begin
                        if(i < 3) AB[i] <= fma_results[i];
                        else AC[i - 3] <= fma_results[i];
                    end 
                end
            end
            //calculate P-R0, where P is any point on the plane
            PREP_VIDFF_2: begin
                for(int i = 0; i < NUM_FMAS; i++) begin
                    if(fma_out_valid[i]) PR[i] <= fma_results[i];
                end
            end
            //calculate the normal, which is AB cross AC
            MAKE_NORMAL: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) normal_vector[i] <= fma_results[i];
                end
            end
            PLANE_DOTS: begin
                if (fma_out_valid[2]) numerator_reg   <= fma_results[2]; // (PR·n)
                if (fma_out_valid[5]) denominator_reg <= fma_results[5]; // (R_d·n)
            end
            DIV_T: begin
                if (div_out_valid) t_reg <= div_unit.result_o;
            end
            TRI_CROSS1: begin
            
            end
            TRI_CROSS2: begin
            
            end
            TRI_DOTS: begin
            
            end
            DIV_E0: begin
            
            end
            DIV_E1: begin
            
            end
            DIV_E2: begin
            
            end
            BARY_DOTS: begin
            
            end
            BARY_FIN: begin
            
            end

            default: ;
        endcase
        for (int i = 0; i < NUM_FMAS; i++) fma_inflight[i] <= fma_inflight_next[i];
    end
end

always_comb begin : transitions
    next_state = state;
    proceed = '0;
    for (int i = 0; i < NUM_FMAS; i++) begin
        srcA_i[i]  = 'x;
        srcB_i[i]  = 'x;
        srcC_i[i]  = 'x;
        fma_op[i]  = 'x;
        fma_mod[i] = 'x;
        fma_inflight_next[i] = fma_inflight[i];
    end


    unique case (state)
        IDLE: begin
            if(input_valid_i) begin 
                proceed = '1;
                next_state = PREP_VDIFF_1;
            end
        end
        //calculate AB, AC
        PREP_VDIFF_1: begin
            proceed = 1'b1; // Assume ready, disprove later
            for (int i = 0; i < NUM_FMAS; i++) begin
                if (!fma_inflight[i]) begin
                    if (!fma_in_ready[i]) proceed = 1'b0;
                end else begin
                    if (!fma_out_valid[i]) proceed = 1'b0;
                end
            end

            // Setup operands: 
            // Perform (1.0 * srcB) - srcC --> (p2 or p1) - p0
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                srcA_i[i]     = 32'h3F800000; // 1.0
                srcB_i[i]     = p2[i];         // p2.x, p2.y, p2.z
                srcC_i[i]     = p0[i];         // p0.x, p0.y, p0.z

                srcA_i[i+3]   = 32'h3F800000; // 1.0
                srcB_i[i+3]   = p1[i];         // p1.x, p1.y, p1.z
                srcC_i[i+3]   = p0[i];         // p0.x, p0.y, p0.z
            end

            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_inflight_next[i] = fma_inflight[i];

                if (!fma_inflight[i]) begin
                    fma_in_valid[i] = 1'b1;
                    fma_op[i]       = fpnew_pkg::ADD;
                    fma_mod[i]      = 1'b1;

                    if (fma_in_ready[i]) begin
                        fma_inflight_next[i] = 1'b1;
                    end else begin
                        // proceed = 1'b0; 
                    end
                end else begin
                    fma_in_valid[i] = 1'b0;
                    if (!fma_out_valid[i]) begin
                        // proceed = 1'b0;
                    end
                end
            end

            if (proceed) begin
                next_state = PREP_VDIFF_2;
                for (int i = 0; i < NUM_FMAS; i++) begin
                    fma_inflight_next[i] = 1'b0;
                end
            end
        end
        //calculate P-R0, where P is any point on the plane
        PREP_VDIFF_2: begin
            proceed = 1'b1; // Assume ready unless proven otherwise

            // Configure FMAs 0-2 for PR = p0 - r0 (1.0*p0 - r0)
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                srcA_i[i]     = 32'h3F800000; // 1.0
                srcB_i[i]     = p0[i];        // p0.x, p0.y, p0.z
                srcC_i[i]     = r0[i];        // r0.x, r0.y, r0.z
                fma_op[i]     = fpnew_pkg::ADD;
                fma_mod[i]    = 1'b1;         // Subtract mode

                // Check if FMA is ready or has valid output
                if (!fma_inflight[i]) begin
                    if (!fma_in_ready[i]) proceed = 1'b0; // FMA busy
                end else begin
                    if (!fma_out_valid[i]) proceed = 1'b0; // Result not ready
                end

                // Update inflight status
                fma_inflight_next[i] = fma_inflight[i];
                if (!fma_inflight[i] && fma_in_ready[i]) begin
                    fma_inflight_next[i] = 1'b1; // Mark inflight
                end else if (fma_out_valid[i]) begin
                    fma_inflight_next[i] = 1'b0; // Clear on completion
                end
            end

            // Unused FMAs (3-5) are idle
            for (int i = NUM_DIMENSIONS; i < NUM_FMAS; i++) begin
                fma_in_valid[i] = 1'b0;
                fma_inflight_next[i] = 1'b0;
            end

            // Transition to next state once all FMAs complete
            if (proceed) begin
                next_state = MAKE_NORMAL;
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    fma_inflight_next[i] = 1'b0; // Reset inflight
                end
            end
        end
        MAKE_NORMAL: begin
            proceed = 1'b1; // Assume ready unless proven otherwise

            // Configure FMAs 0-5 for cross product (AB × AC)
            // n.x = AB.y*AC.z - AB.z*AC.y
            // n.y = AB.z*AC.x - AB.x*AC.z
            // n.z = AB.x*AC.y - AB.y*AC.x
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                // First FMA computes positive term (e.g., AB.y*AC.z for n.x)
                srcA_i[2*i]   = (i == 0) ? AB[1] : (i == 1) ? AB[2] : AB[0]; // AB.y, AB.z, AB.x
                srcB_i[2*i]   = (i == 0) ? AC[2] : (i == 1) ? AC[0] : AC[1]; // AC.z, AC.x, AC.y
                srcC_i[2*i]   = '0;
                fma_op[2*i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[2*i] = 1'b0;

                // Second FMA computes negative term and subtracts (e.g., -AB.z*AC.y + prev_result)
                srcA_i[2*i+1] = 32'hBF800000; // -1.0 (FP32)
                srcB_i[2*i+1] = (i == 0) ? AB[2] : (i == 1) ? AB[0] : AB[1]; // AB.z, AB.x, AB.y
                srcC_i[2*i+1] = (fma_out_valid[2*i]) ? fma_results[2*i] : '0; // Result from first FMA
                fma_op[2*i+1] = fpnew_pkg::ADD;
                fma_mod[2*i+1] = 1'b0; // Regular add (C is already positive/negative)

                // Check readiness for both FMAs per component
                for (int j = 0; j < 2; j++) begin
                    int fma_idx = 2*i + j;
                    if (!fma_inflight[fma_idx]) begin
                        if (!fma_in_ready[fma_idx]) proceed = 1'b0;
                    end else begin
                        if (!fma_out_valid[fma_idx]) proceed = 1'b0;
                    end
                end
            end

            // Update inflight status
            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_inflight_next[i] = fma_inflight[i];
                if (!fma_inflight[i] && fma_in_ready[i]) begin
                    fma_inflight_next[i] = 1'b1;
                end else if (fma_out_valid[i]) begin
                    fma_inflight_next[i] = 1'b0;
                end
            end

            // Transition to PLANE_DOTS once all FMAs complete
            if (proceed) begin
                next_state = PLANE_DOTS;
                for (int i = 0; i < NUM_FMAS; i++) fma_inflight_next[i] = 1'b0;
            end
        end

        PLANE_DOTS: begin
            proceed = 1'b1; // Assume ready unless proven otherwise

            //---------------------------
            // Numerator: (PR·n) = PR.x*n.x + PR.y*n.y + PR.z*n.z
            //---------------------------
            // FMA0: PR.x*n.x + 0 → term0
            srcA_i[0] = PR[0];         // PR.x
            srcB_i[0] = normal_vector[0]; // n.x
            srcC_i[0] = 32'h0;          // 0.0
            fma_op[0] = fpnew_pkg::MUL; // Multiply-only (no add)
            fma_mod[0] = 1'b0;

            // FMA1: PR.y*n.y + term0 → term0 + term1
            srcA_i[1] = PR[1];         // PR.y
            srcB_i[1] = normal_vector[1]; // n.y
            srcC_i[1] = fma_results[0];  // Previous result (term0)
            fma_op[1] = fpnew_pkg::ADD;  // (A*B) + C
            fma_mod[1] = 1'b0;

            // FMA2: PR.z*n.z + (term0 + term1) → final numerator
            srcA_i[2] = PR[2];         // PR.z
            srcB_i[2] = normal_vector[2]; // n.z
            srcC_i[2] = fma_results[1];  // Previous sum (term0 + term1)
            fma_op[2] = fpnew_pkg::ADD;
            fma_mod[2] = 1'b0;

            //---------------------------
            // Denominator: (R_d·n) = rd.x*n.x + rd.y*n.y + rd.z*n.z
            //---------------------------
            // FMA3: rd.x*n.x + 0 → term2
            srcA_i[3] = rd[0];         // rd.x
            srcB_i[3] = normal_vector[0]; // n.x
            srcC_i[3] = 32'h0;
            fma_op[3] = fpnew_pkg::MUL;
            fma_mod[3] = 1'b0;

            // FMA4: rd.y*n.y + term2 → term2 + term3
            srcA_i[4] = rd[1];         // rd.y
            srcB_i[4] = normal_vector[1]; // n.y
            srcC_i[4] = fma_results[3];  // Previous result (term2)
            fma_op[4] = fpnew_pkg::ADD;
            fma_mod[4] = 1'b0;

            // FMA5: rd.z*n.z + (term2 + term3) → final denominator
            srcA_i[5] = rd[2];         // rd.z
            srcB_i[5] = normal_vector[2]; // n.z
            srcC_i[5] = fma_results[4];  // Previous sum (term2 + term3)
            fma_op[5] = fpnew_pkg::ADD;
            fma_mod[5] = 1'b0;

            // Check readiness for all FMAs
            for (int i = 0; i < NUM_FMAS; i++) begin
                if (!fma_inflight[i]) begin
                    if (!fma_in_ready[i]) proceed = 1'b0; // FMA busy
                end else begin
                    if (!fma_out_valid[i]) proceed = 1'b0; // Result pending
                end
            end

            // Update inflight status
            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_inflight_next[i] = fma_inflight[i];
                if (!fma_inflight[i] && fma_in_ready[i]) begin
                    fma_inflight_next[i] = 1'b1; // Mark inflight
                end else if (fma_out_valid[i]) begin
                    fma_inflight_next[i] = 1'b0; // Clear on completion
                end
            end

            // Transition to DIV_T once all FMAs complete
            if (proceed) begin
                next_state = DIV_T;
                for (int i = 0; i < NUM_FMAS; i++) fma_inflight_next[i] = 1'b0;
            end
        end
        DIV_T: begin

        end
        TRI_CROSS1: begin
        
        end
        TRI_CROSS2: begin
        
        end
        TRI_DOTS: begin
        
        end
        DIV_E0: begin
        
        end
        DIV_E1: begin
        
        end
        DIV_E2: begin
        
        end
        BARY_DOTS: begin
        
        end
        BARY_FIN: begin
        
        end
        default: next_state = state;
    endcase
end

//---------------
// FPU instance(s)
//---------------

genvar i;
generate
for (i = 0; i < NUM_FMAS; i++) begin : FMAs
    fpnew_top #(
        .Features      (Features),
        .Implementation(ImplFMA),
        .TagType       (tag_t)
    ) fma (
        .clk_i     (clk),
        .rst_ni    (rst_n),
        .operands_i( {srcA_i[i], srcB_i[i], srcC_i[i]}),
        .rnd_mode_i( fpnew_pkg::RNE ),
        .op_i      ( fma_op[i]  ), // ADD/MUL/FMA selected via op/op_mod (fpnew_pkg::FMADD)
        .op_mod_i  ( fma_mod[i] ),             // 0 = FMA / + , 1 = FMS / −
        .src_fmt_i ( fpnew_pkg::FP32 ),
        .dst_fmt_i ( fpnew_pkg::FP32 ),
        .in_valid_i(fma_in_valid[i]),
        .in_ready_o(fma_in_ready[i]),
        .flush_i   ( 1'b0 ),
        .result_o  ( fma_results[i] ),
        .out_valid_o(fma_out_valid[i]),
        .out_ready_i('1),               //Our device is always ready for outputs
        .busy_o    (),

        .tag_i     (),
        .tag_o     ()
    );
end
endgenerate 

//------------------------------------------------------------------------
// Single divider / sqrt unit
//------------------------------------------------------------------------
fpnew_top #(
    .Features      (Features),
    .Implementation(ImplDIV),
    .TagType       (tag_t)
) div_unit (
    .clk_i     (clk),
    .rst_ni    (rst_n),
    .operands_i( /* dividend, divisor, dummy */ ),
    .rnd_mode_i( fpnew_pkg::RNE ),
    .op_i      ( fpnew_pkg::DIV ),
    .op_mod_i  ( 1'b0 ),
    .src_fmt_i ( fpnew_pkg::FP32 ),
    .dst_fmt_i ( fpnew_pkg::FP32 ),
    .in_valid_i(div_in_valid),
    .in_ready_o(div_in_ready),
    .flush_i   ( 1'b0 ),
    .result_o  ( /* quotient */ ),
    .out_valid_o(div_out_valid),
    .out_ready_i('1),               //our device is always ready for outputs
    .busy_o    (),

    .tag_i     (),
    .tag_o     ()
);

endmodule
