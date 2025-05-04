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

typedef enum logic [4:0] {
    IDLE,
                        // All vector subtractions that do NOT depend on n
    PREP_VDIFF_1,
    PREP_VDIFF_2,     //   – AB,  AC,  A-R0                       ( 9 subs)     

    MAKE_NORMAL_1,    // n = AB × AC                              ( 6 mul + 3 add )
    MAKE_NORMAL_2,      

    PLANE_DOTS_1,       // (P-R0)·n  ||  R_d·n                      ( 6 mul + 4 add )
    PLANE_DOTS_2,

    DIV_T,            // t = num/den                              ( 1 div )

    INTERSECTION,     // P' = trd + r0                            ()

    TRI_CROSS1,       // a1 = (P2-P0) × n                         ( 6 mul + 3 add )
    TRI_CROSS2,       // a2 = (P1-P0) × n                         ( 6 mul + 3 add )
    TRI_CROSS3,
    TRI_CROSS4, 

    TRI_DOTS1,         // den1 = a1·(P1-P0) || den2 = a2·(P2-P0)   ( 6 mul + 4 add )
    TRI_DOTS2,
    TRI_DOTS3,
    TRI_DOTS4,

    P_COMPUTE,           //p - p0

    BARY_DOTS1,        // b1, b2  (two dot products)               ( 6 mul + 4 add )
    BARY_DOTS1_CMP,
    BARY_DOTS2,
    BARY_DOTS2_CMP,

    BARY_FIN,          // b0 = 1 - b1 - b2  (+ inside-triangle test)
    BARY_FIN_CMP,

    NO_INT,              //No intersection was found, end early

    INT                 //Intersection found, return point
} plane_ray_state_t;

plane_ray_state_t state, next_state;

logic [31:0] srcA_i [NUM_FMAS];
logic [31:0] srcB_i [NUM_FMAS];
logic [31:0] srcC_i [NUM_FMAS];

logic fma_in_ready[NUM_FMAS];
logic div_in_ready[NUM_DIMENSIONS];
logic fma_in_valid[NUM_FMAS];
logic div_in_valid[NUM_DIMENSIONS];
logic fma_out_valid[NUM_FMAS];
logic div_out_valid[NUM_DIMENSIONS];

logic cmp_in_ready, cmp_in_valid, cmp_out_valid;
logic [31:0] cmp_results;
logic [31:0] cmp_op;

logic [3:0] fma_op[NUM_FMAS];
logic fma_mod[NUM_FMAS];

logic [31:0] fma_results[NUM_FMAS];
logic [31:0] div_results[NUM_DIMENSIONS];

logic [31:0] normal_vector          [NUM_DIMENSIONS];
logic [31:0] numerator_reg, denominator_reg;
logic [31:0] numerator_reg_int [NUM_DIMENSIONS]; 
logic [31:0] denominator_reg_int [NUM_DIMENSIONS];
logic [31:0] t_reg;
logic [31:0] intersection_pt        [NUM_DIMENSIONS];
logic [31:0] p_p0               [NUM_DIMENSIONS];

logic [31:0] a1 [NUM_DIMENSIONS];
logic [31:0] a2 [NUM_DIMENSIONS];

logic [31:0] e1 [NUM_DIMENSIONS];
logic [31:0] e2 [NUM_DIMENSIONS];

logic [31:0] b0;
logic [31:0] b1;
logic [31:0] b2;

logic [31:0] dot_1_int;
logic [31:0] dot_2_int;
logic [31:0] temp;

logic [31:0] AB   [NUM_DIMENSIONS];
logic [31:0] AC   [NUM_DIMENSIONS];
logic [31:0] PR   [NUM_DIMENSIONS]; 

logic [31:0] normal_intermediate [NUM_FMAS];

logic proceed;
logic valid_register;


always_ff @(posedge clk) begin : transition_exec_save_outs
    if(!rst_n) begin
        state <= IDLE;
        for(int i = 0; i < NUM_DIMENSIONS; i++) begin
            AB[i] <= '0;
            AC[i] <= '0;
            PR[i] <= '0;
            normal_vector[i] <= '0;
        end
        valid_register <= '0;

        return_o <= '0;
        output_valid_o <= '0;

    end else begin
        
        if(proceed) valid_register <= '0;
        else valid_register <= '1;

        state <= next_state;
        
        unique case (state)
            IDLE: begin
                return_o <= '0;
                output_valid_o <= 1'b0;
            end
            //calculate AB, AC
            PREP_VDIFF_1: begin
                for(int i = 0; i < NUM_FMAS; i++) begin
                    if(fma_out_valid[i]) begin
                        if(i < 3) AC[i] <= fma_results[i];
                        else AB[i - 3] <= fma_results[i];
                    end 
                end
            end
            //calculate P-R0, where P is any point on the plane
            PREP_VDIFF_2: begin
                for(int i = 0; i < NUM_FMAS; i++) begin
                    if(fma_out_valid[i]) PR[i] <= fma_results[i];
                end
            end
            //load intermediate normal registers
            MAKE_NORMAL_1: begin
                for (int i = 0; i < NUM_FMAS; i++) begin
                    if (fma_out_valid[i]) normal_intermediate[i] <= fma_results[i];
                end
            end
            //calculate the normal, which is AB cross AC
            MAKE_NORMAL_2: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) normal_vector[i] <= fma_results[i];
                end
            end
            PLANE_DOTS_1: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) begin 
                        numerator_reg_int[i] <= fma_results[i];
                        denominator_reg_int[i] <= fma_results[i + 3];
                    end
                end
            end
            PLANE_DOTS_2: begin
                if (fma_out_valid[0]) numerator_reg   <= fma_results[0]; // (PR·n)
                if (fma_out_valid[1]) denominator_reg <= fma_results[1]; // (R_d·n)
            end
            DIV_T: begin
                if (div_out_valid[0]) t_reg <= div_results[0];
            end
            INTERSECTION: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) intersection_pt[i] <= fma_results[i];
                end
            end
            TRI_CROSS1: begin
                for (int i = 0; i < NUM_FMAS; i++) begin
                    if (fma_out_valid[i]) normal_intermediate[i] <= fma_results[i];
                end
            end
            TRI_CROSS2: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) a1[i] <= fma_results[i];
                end
            end
            TRI_CROSS3: begin
                for (int i = 0; i < NUM_FMAS; i++) begin
                    if (fma_out_valid[i]) normal_intermediate[i] <= fma_results[i];
                end
            end
            TRI_CROSS4: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) a2[i] <= fma_results[i];
                end
            end

            TRI_DOTS1: begin
                if(fma_out_valid[4]) dot_1_int <= fma_results[4];
                if(fma_out_valid[2]) temp <= fma_results[2];
            end
            TRI_DOTS2: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (div_out_valid[i]) e1[i] <= div_results[i];
                end
            end
            TRI_DOTS3: begin
                if(fma_out_valid[4]) dot_2_int <= fma_results[4];
                if(fma_out_valid[2]) temp <= fma_results[2];
            end
            TRI_DOTS4: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (div_out_valid[i]) e2[i] <= div_results[i];
                end
            end

            P_COMPUTE: begin
                for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                    if (fma_out_valid[i]) p_p0[i] <= fma_results[i];
                end
            end
            BARY_DOTS1: begin
                if(fma_out_valid[4]) b1 <= fma_results[4];
                if(fma_out_valid[2]) temp <= fma_results[2];
            end
            BARY_DOTS2: begin
                if(fma_out_valid[4]) b2 <= fma_results[4];
                if(fma_out_valid[2]) temp <= fma_results[2];
            end
            BARY_FIN: begin
                if(fma_out_valid[0]) b0 <= fma_results[0];
            end

            INT: begin
                return_o <= 1'b1;
                output_valid_o <= 1'b1;
            end

            NO_INT: begin
                return_o <= 1'b0;
                output_valid_o <= 1'b1;
            end

            default: ;
        endcase
    end
end

always_comb begin : transitions
    next_state = state;
    proceed = 1'b0;
    for (int i = 0; i < NUM_FMAS; i++) begin
        srcA_i[i]  = 'x;
        srcB_i[i]  = 'x;
        srcC_i[i]  = 'x;
        fma_op[i]  = '0;
        fma_mod[i] = '0;
        fma_in_valid[i] = '0;
    end

    for (int i = 0; i < NUM_DIMENSIONS; i++) div_in_valid[i] = '0;
    cmp_in_valid = '0;
    cmp_op = '0;

    unique case (state)
        IDLE: begin
            if(input_valid_i) begin 
                proceed = '1;
                next_state = PREP_VDIFF_1;
            end
        end
        //calculate AB, AC
        PREP_VDIFF_1: begin
            for (int i = 0; i < NUM_FMAS; i++) begin
                if (i < 3) begin  // First 3 FMAs: AC = p2-p0
                    srcB_i[i] = p2[i];          // p2.x, p2.y, p2.z
                    srcC_i[i] = p0[i];          // p0.x, p0.y, p0.z
                end else begin    // Last 3 FMAs: AB = p1-p0
                    srcB_i[i] = p1[i-3];        // p1.x, p1.y, p1.z
                    srcC_i[i] = p0[i-3];        // p0.x, p0.y, p0.z
                end
                fma_op[i] = fpnew_pkg::ADD;
                fma_mod[i] = 1'b1;  // Subtraction mode
                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end

            if (proceed) next_state = PREP_VDIFF_2;
        end
        //calculate P-R0, where P is any point on the plane
        PREP_VDIFF_2: begin

            // Configure FMAs 0-2 for PR = p0 - r0 (1.0*p0 - r0)
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                srcB_i[i]     = p0[i];        // p0.x, p0.y, p0.z
                srcC_i[i]     = r0[i];        // r0.x, r0.y, r0.z
                fma_op[i]     = fpnew_pkg::ADD;
                fma_mod[i]    = 1'b1;         // Subtract mode
            end

            // Unused FMAs (3-5) are idle
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end

            if (proceed) next_state = MAKE_NORMAL_1;
        end
        MAKE_NORMAL_1: begin
            // Configure FMAs 0-5 for cross product multiplies)
            // n.x = AB.y*AC.z , AB.z*AC.y
            // n.y = AB.z*AC.x , AB.x*AC.z
            // n.z = AB.x*AC.y , AB.y*AC.x
            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end
            
            srcA_i[0] = AB[1]; //AB.y*AC.z
            srcB_i[0] = AC[2]; 

            srcA_i[1] = AB[2]; //AB.z*AC.x
            srcB_i[1] = AC[0];

            srcA_i[2] = AB[0]; //AB.x*AC.y
            srcB_i[2] = AC[1];

            srcA_i[3] = AB[2]; //AB.z*AC.y
            srcB_i[3] = AC[1];

            srcA_i[4] = AB[0]; //AB.x*AC.z
            srcB_i[4] = AC[2];

            srcA_i[5] = AB[1]; //AB.y*AC.x
            srcB_i[5] = AC[0];

            if (proceed) next_state = MAKE_NORMAL_2;
        end

        MAKE_NORMAL_2: begin
            // Configure FMAs 0-2 for cross product subtractions
            // n.x = AB.y*AC.z - AB.z*AC.y
            // n.y = AB.z*AC.x - AB.x*AC.z
            // n.z = AB.x*AC.y - AB.y*AC.x
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b1;           // Modifier 1 (Subtract)

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                srcB_i[i] = normal_intermediate[i];
                srcC_i[i] = normal_intermediate[i + 3];
            end

            if (proceed) next_state = PLANE_DOTS_1;
        end

        PLANE_DOTS_1: begin
            // Configure FMAs 0-5 for intermediate dot products
            for(int i = 0; i < NUM_FMAS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply
                fma_mod[i]  = 1'b0;           // Modifier 0

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                if(i < 3) begin
                    srcA_i[i] = PR[i];
                    srcB_i[i] = normal_vector[i];
                end else begin
                    srcA_i[i] = rd[i - 3];
                    srcB_i[i] = normal_vector[i - 3];
                end 

            end

            if (proceed) next_state = PLANE_DOTS_2;
        end
        PLANE_DOTS_2: begin

            // Configure FMAs 2-3 for intermediate accumulations
            for(int i = 2; i < 4; i++) begin
                if(!valid_register) fma_in_valid[i] = 1'b1;
            end

            srcB_i[2] = numerator_reg_int[0];
            srcC_i[2] = numerator_reg_int[1];

            srcB_i[3] = denominator_reg_int[0];
            srcC_i[3] = denominator_reg_int[1];


            // Configure FMAs 0-1 for final accumulation
            for(int i = 0; i < 2; i++) begin
                if(fma_out_valid[2]) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end

            srcB_i[0] = fma_results[2];
            srcC_i[0] = numerator_reg_int[2];

            srcB_i[1] = fma_results[3];
            srcC_i[1] = denominator_reg_int[2];

            for(int i = 0; i < NUM_FMAS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b0;           // Modifier 0
            end

            if (proceed) next_state = DIV_T;

        end
        DIV_T: begin
            //Divide (p - r0 . n) / (r_d . n)
            if(!valid_register) div_in_valid[0] = 1'b1;

            srcA_i[0] = numerator_reg;
            srcB_i[0] = denominator_reg;

            if(div_out_valid[0]) proceed = 1'b1;

            if (proceed) begin 
                if(div_results[0][0] == 0 && div_results[0] != 32'b0) next_state = INTERSECTION;
                else next_state = NO_INT;
            end
        end
        INTERSECTION: begin

            //compute p' = t_rd + r0

            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::FMADD; // Multiply-Acumulate
                fma_mod[i]  = 1'b0;           // Modifier 0 (Subtract)

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                srcA_i[i] = t_reg;
                srcB_i[i] = rd[i];
                srcC_i[i] = r0[i];
            end

            if (proceed) next_state = TRI_CROSS1;

        end
        TRI_CROSS1: begin
            // Configure FMAs 0-5 for cross product multiplies)
            // AC.y*n.z , AC.z*n.y
            // AC.z*n.x , AC.x*n.z
            // AC.x*n.y , AC.y*n.x
            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end
            
            srcA_i[0] = AC[1]; //AC.y*normal_vector.z
            srcB_i[0] = normal_vector[2]; 

            srcA_i[1] = AC[2]; //AC.z*normal_vector.x
            srcB_i[1] = normal_vector[0];

            srcA_i[2] = AC[0]; //AC.x*normal_vector.y
            srcB_i[2] = normal_vector[1];

            srcA_i[3] = AC[2]; //AC.z*normal_vector.y
            srcB_i[3] = normal_vector[1];

            srcA_i[4] = AC[0]; //AC.x*normal_vector.z
            srcB_i[4] = normal_vector[2];

            srcA_i[5] = AC[1]; //AC.y*normal_vector.x
            srcB_i[5] = normal_vector[0];

            if (proceed) next_state = TRI_CROSS2;
        end
        TRI_CROSS2: begin
            // Configure FMAs 0-2 for cross product subtractions
            // a1.x = AC.y*n.z - AC.z*n.y
            // a1.y = AC.z*n.x - AC.x*n.z
            // a1.z = AC.x*n.y - AC.y*n.x
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b1;           // Modifier 1 (Subtract)

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                srcB_i[i] = normal_intermediate[i];
                srcC_i[i] = normal_intermediate[i + 3];
            end

            if (proceed) next_state = TRI_CROSS3;
        
        end
        TRI_CROSS3: begin
            // Configure FMAs 0-5 for cross product multiplies)
            // AB.y*n.z , AB.z*n.y
            // AB.z*n.x , AB.x*n.z
            // AB.x*n.y , AB.y*n.x
            for (int i = 0; i < NUM_FMAS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;
            end
            
            srcA_i[0] = AB[1]; //AB.y*normal_vector.z
            srcB_i[0] = normal_vector[2]; 

            srcA_i[1] = AB[2]; //AB.z*normal_vector.x
            srcB_i[1] = normal_vector[0];

            srcA_i[2] = AB[0]; //AB.x*normal_vector.y
            srcB_i[2] = normal_vector[1];

            srcA_i[3] = AB[2]; //AB.z*normal_vector.y
            srcB_i[3] = normal_vector[1];

            srcA_i[4] = AB[0]; //AB.x*normal_vector.z
            srcB_i[4] = normal_vector[2];

            srcA_i[5] = AB[1]; //AB.y*normal_vector.x
            srcB_i[5] = normal_vector[0];

            if (proceed) next_state = TRI_CROSS4;
        end
        TRI_CROSS4: begin
            // Configure FMAs 0-2 for cross product subtrABtions
            // a1.x = AB.y*n.z - AB.z*n.y
            // a1.y = AB.z*n.x - AB.x*n.z
            // a1.z = AB.x*n.y - AB.y*n.x
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b1;           // Modifier 1 (Subtract)

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                srcB_i[i] = normal_intermediate[i];
                srcC_i[i] = normal_intermediate[i + 3];
            end

            if (proceed) next_state = TRI_DOTS1;
        
        end
        TRI_DOTS1: begin
            // Compute a1.AB
            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                srcA_i[i] = a1[i];
                srcB_i[i] = AB[i];

                if(!valid_register) fma_in_valid[i] = 1'b1;
            end

            for(int i = 3; i < 5; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b0;           // No Modifier
            end

            srcB_i[3] = fma_results[0];
            srcC_i[3] = fma_results[1];

            srcB_i[4] = fma_results[3];
            srcC_i[4] = temp;

            if(fma_out_valid[2]) fma_in_valid[3] = 1'b1;
            if(fma_out_valid[3]) fma_in_valid[4] = 1'b1;
            if(fma_out_valid[4]) proceed = 1'b1;

            if (proceed) next_state = TRI_DOTS2;
        end
        TRI_DOTS2: begin
            //compute e1 = a1 / a1.AB

            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                if(!valid_register) div_in_valid[i] = 1'b1;

                srcA_i[i] = a1[i];
                srcB_i[i] = dot_1_int;

                if (div_out_valid[i]) proceed = 1'b1;
            end 

            if (proceed) next_state = TRI_DOTS3;
        end
        TRI_DOTS3: begin
            // Compute a2.AC
            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                srcA_i[i] = a2[i];
                srcB_i[i] = AC[i];

                if(!valid_register) fma_in_valid[i] = 1'b1;
            end

            for(int i = 3; i < 5; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b0;           // No Modifier
            end

            srcB_i[3] = fma_results[0];
            srcC_i[3] = fma_results[1];

            srcB_i[4] = fma_results[3];
            srcC_i[4] = temp;

            if(fma_out_valid[2]) fma_in_valid[3] = 1'b1;
            if(fma_out_valid[3]) fma_in_valid[4] = 1'b1;
            if(fma_out_valid[4]) proceed = 1'b1;

            if (proceed) next_state = TRI_DOTS4;
        end
        TRI_DOTS4: begin
            //compute e1 = a2 / a2.AC

            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                if(!valid_register) div_in_valid[i] = 1'b1;

                srcA_i[i] = a2[i];
                srcB_i[i] = dot_2_int;

                if (div_out_valid[i]) proceed = 1'b1;
            end 

            if (proceed) next_state = P_COMPUTE;
        end

        P_COMPUTE: begin
            // Configure FMAs 0-2 for p-p0 subtractions
            for (int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b1;           // Modifier 1 (Subtract)

                if(!valid_register) fma_in_valid[i] = 1'b1;
                if (fma_out_valid[i]) proceed = 1'b1;

                srcB_i[i] = intersection_pt[i];
                srcC_i[i] = p0[i];
            end

            if (proceed) next_state = BARY_DOTS1;
        end

        BARY_DOTS1: begin
            // Compute e1.p_p0
            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                srcA_i[i] = e1[i];
                srcB_i[i] = p_p0[i];

                if(!valid_register) fma_in_valid[i] = 1'b1;
            end

            for(int i = 3; i < 5; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b0;           // No Modifier
            end

            srcB_i[3] = fma_results[0];
            srcC_i[3] = fma_results[1];

            srcB_i[4] = fma_results[3];
            srcC_i[4] = temp;

            if(fma_out_valid[2]) fma_in_valid[3] = 1'b1;
            if(fma_out_valid[3]) fma_in_valid[4] = 1'b1;
            if(fma_out_valid[4]) proceed = 1'b1;

            if (proceed) begin 
                if(fma_results[4][0] == 1'b1 || fma_results[4] == 32'b0) next_state = NO_INT;
                else next_state = BARY_DOTS1_CMP;
            end
        end
        BARY_DOTS1_CMP: begin
            cmp_op = fpnew_pkg::RTZ;
            if(!valid_register) cmp_in_valid = 1'b1;
            srcA_i[0] = b1;


            if (cmp_out_valid) proceed = 1'b1;

            if (proceed) begin 
                if(cmp_results == 1'b0) next_state = NO_INT;
                else next_state = BARY_DOTS2;
            end 
        end
        BARY_DOTS2: begin
            // Compute e2.p_p0
            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::MUL; // Multiply-only (no add)
                fma_mod[i]  = 1'b0;           // No Modifier

                srcA_i[i] = e2[i];
                srcB_i[i] = p_p0[i];

                if(!valid_register) fma_in_valid[i] = 1'b1;
            end

            for(int i = 3; i < 5; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b0;           // No Modifier
            end

            srcB_i[3] = fma_results[0];
            srcC_i[3] = fma_results[1];

            srcB_i[4] = fma_results[3];
            srcC_i[4] = temp;

            if(fma_out_valid[2]) fma_in_valid[3] = 1'b1;
            if(fma_out_valid[3]) fma_in_valid[4] = 1'b1;
            if(fma_out_valid[4]) proceed = 1'b1;

            if (proceed) begin 
                if(fma_results[4][0] == 1'b1 || fma_results[4] == 32'b0) next_state = NO_INT;
                else next_state = BARY_DOTS2_CMP;
            end
            
        end
        BARY_DOTS2_CMP: begin
            cmp_op = fpnew_pkg::RTZ;
            if(!valid_register) cmp_in_valid = 1'b1;
            srcA_i[0] = b2;


            if (cmp_out_valid) proceed = 1'b1;

            if (proceed) begin 
                if(cmp_results == 1'b0) next_state = NO_INT;
                else next_state = BARY_FIN;
            end 
        end

        BARY_FIN: begin
            for(int i = 0; i < NUM_DIMENSIONS; i++) begin
                fma_op[i]   = fpnew_pkg::ADD; // Add
                fma_mod[i]  = 1'b1;           // Subtraction Modifier
            end

            fma_in_valid[0] = 1'b1;
            srcB_i[0] = 32'h3F800000;
            srcC_i[0] = b1;

            srcB_i[1] = fma_results[0];
            srcC_i[1] = b2;

            if(fma_out_valid[0]) fma_in_valid[1] = 1'b1;
            if(fma_out_valid[1]) proceed = 1'b1;

            if (proceed) begin 
                 if(fma_results[1][0] == 1'b1 || fma_results[1] == 32'b0) next_state = NO_INT;
                 else next_state = BARY_FIN_CMP;
            end
        end

        BARY_FIN_CMP: begin
            cmp_op = fpnew_pkg::RTZ;
            if(!valid_register) cmp_in_valid = 1'b1;
            srcA_i[0] = b0;


            if (cmp_out_valid) proceed = 1'b1;

            if (proceed) begin 
                if(cmp_results == 1'b0) next_state = NO_INT;
                else next_state = INT;
            end 
        end

        NO_INT, INT: next_state = IDLE;
    
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
        .operands_i({srcC_i[i], srcB_i[i], srcA_i[i]}),
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
// Three Dividers
//------------------------------------------------------------------------
genvar i;
generate
for (i = 0; i < NUM_DIMENSIONS; i++) begin : DIVs
fpnew_top #(
    .Features      (Features),
    .Implementation(ImplDIV),
    .TagType       (tag_t)
) div (
    .clk_i     (clk),
    .rst_ni    (rst_n),
    .operands_i({srcB_i[i], srcA_i[i]}),
    .rnd_mode_i( fpnew_pkg::RNE ),
    .op_i      ( fpnew_pkg::DIV ),
    .op_mod_i  ( 1'b0 ),
    .src_fmt_i ( fpnew_pkg::FP32 ),
    .dst_fmt_i ( fpnew_pkg::FP32 ),
    .in_valid_i(div_in_valid[i]),
    .in_ready_o(div_in_ready[i]),
    .flush_i   ( 1'b0 ),
    .result_o  ( div_results[i]),
    .out_valid_o(div_out_valid[i]),
    .out_ready_i('1),               //our device is always ready for outputs
    .busy_o    (),

    .tag_i     (),
    .tag_o     ()
);
end
endgenerate

fpnew_top #(
    .Features      (Features),
    .Implementation(ImplCMP),
    .TagType       (tag_t)
) cmp (
    .clk_i     (clk),
    .rst_ni    (rst_n),
    .operands_i({32'h3F800000, srcA_i[0]}),
    .rnd_mode_i( cmp_op),
    .op_i      ( fpnew_pkg::CMP ),
    .op_mod_i  ( 1'b0 ),
    .src_fmt_i ( fpnew_pkg::FP32 ),
    .dst_fmt_i ( fpnew_pkg::FP32 ),
    .in_valid_i(cmp_in_valid),
    .in_ready_o(cmp_in_ready),
    .flush_i   ( 1'b0 ),
    .result_o  ( cmp_results),
    .out_valid_o(cmp_out_valid),
    .out_ready_i('1),               //our device is always ready for outputs
    .busy_o    (),

    .tag_i     (),
    .tag_o     ()
);

endmodule
