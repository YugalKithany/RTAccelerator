import apu_core_package::*;
import riscv_defines::*;
import fpnew_pkg::*;

// -----------
// FPU Config
// -----------
// Features
localparam fpu_features_t Features = '{
    Width          : 32,            //Single Precision (F Extension) Only
    EnableVectors  : 1'b0,          //No need for vectorial support on thinner dtypes
    EnableNanBox   : 1'b0,          //No need for NaN Boxed  inputs
    FpFmtMask      : '{
        FP32      : 1'b1,           //Set the Single-Precision bit to high
        default   : 1'b0            //Set others to 0
    },
    IntFmtMask     : '0             // no need for FP<->int conversions
};

//---------------------------------------------------------------------
// Implementation tables
//---------------------------------------------------------------------
// 6 FMAs  –> 6 separate fpnew_top instances, each with PARALLEL ADDMUL
fmt_unit_types_t fp32_fma  = '{FP32: PARALLEL, default: DISABLED};
fmt_unit_types_t fp32_off  = '{default: DISABLED};
fmt_unit_types_t fp32_div  = '{FP32: MERGED,   default: DISABLED};

opgrp_fmt_unit_types_t UnitTypesFMA = '{
      ADDMUL  : fp32_fma,   // <— only ADD/MUL/FMA enabled
      default : fp32_off
};

opgrp_fmt_unit_types_t UnitTypesDIV = '{
      DIVSQRT : fp32_div,   // <— only divider enabled
      default : fp32_off
};

// 2-cycle pipeline in each FMA slice, 4-cycle divider (good balance between area and timing)
opgrp_fmt_unsigned_t PipeRegsFMA = '{
      ADDMUL  : '{FP32: 2, default: 0},
      default : '{default: 0}
};
opgrp_fmt_unsigned_t PipeRegsDIV = '{
      DIVSQRT : '{FP32: 4, default: 0},
      default : '{default: 0}
};

localparam pipe_config_t PIPECFG = DISTRIBUTED;

localparam fpu_implementation_t ImplFMA = '{
      PipeRegs   : PipeRegsFMA,
      UnitTypes  : UnitTypesFMA,
      PipeConfig : PIPECFG
};

localparam fpu_implementation_t ImplDIV = '{
      PipeRegs   : PipeRegsDIV,
      UnitTypes  : UnitTypesDIV,
      PipeConfig : PIPECFG
};

typedef logic [4:0] tag_t;

module triangle_vector_int
#(
    parameter FP_DIVSQRT = 1,
    parameter TAG_W = $bits(tag_t)
)
(
    input  logic                     clk,
    input  logic                     rst_n,

    input  logic [31:0]              fprti_regs_i [15],
    input  logic                     input_valid_i,
    
    output logic [31:0]              return_o,
    output logic                     output_valid_o
);

//Sample inputs with local registers (unkown if CPU will hold them throughout computation)
logic [31:0] fprti_regs [15];
always_ff @(posedge clk) begin
    if(!rst_n) begin
        for(int i = 0; i < 15; i++) begin 
            fprti_regs[i] <= '0;
        end
    end else begin
        if(input_valid_i) begin
            for(int i = 0; i < 15; i++) begin 
                fprti_regs[i] <= fprti_regs_i[i];
            end
        end
    end
end

typedef enum logic [3:0] {
    IDLE,
                        // All vector subtractions that do NOT depend on n
    PREP_VDIFF_1,
    PREP_VDIFF_2,     //   – AB,  AC,  P-R0,  P-P0                 ( ≤12 adds, break into 2 stages?)     

    MAKE_NORMAL,      // n = AB × AC                              ( 6 mul + 3 add )

    PLANE_DOTS,       // (P-R0)·n  ||  R_d·n                      ( 6 mul + 4 add )

    DIV_T,            // t = num/den                              ( 1 div )

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

logic fma_in_valid[6];
logic div_in_valid;

logic fma_out_valid[6];
logic div_out_valid;


always_ff @(posedge clk) begin
    if(!rst_n) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

logic [31:0] normal_vector [3];
logic [31:0] intersection_pt [3];
logic [31:0] intermediate_vector1[3];
logic [31:0] intermediate_vector2[3]; 
logic proceed;

always_comb begin : transitions
    next_state = state;
    proceed = '0;
    unique case (state)
        IDLE: begin
            if(input_valid_i) next_state = PREP_VDIFF_1;
        end
        PREP_VDIFF_1: begin
            proceed = &fma_out_valid;
            if(proceed) next_state = PREP_VDIFF_2;
        end
        PREP_VDIFF_2: begin
            if(proceed) next_state = MAKE_NORMAL;        
        end
        MAKE_NORMAL: begin
        
        end
        PLANE_DOTS: begin
        
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
for (i = 0; i < 6; i++) begin : FMAs
    fpnew_top #(
        .Features      (Features),
        .Implementation(ImplFMA),
        .TagType       (tag_t)
    ) fma (
        .clk_i     (clk_i),
        .rst_ni    (rst_ni),
        .operands_i( /* connect op[0..2] for lane i */ ),
        .rnd_mode_i( fpnew_pkg::RNE ),   // or drive dynamically
        .op_i      ( fpnew_pkg::FMADD ), // ADD/MUL/FMA selected via op/op_mod
        .op_mod_i  ( 1'b0 ),             // 0 = FMA / + , 1 = FMS / −
        .src_fmt_i ( fpnew_pkg::FP32 ),
        .dst_fmt_i ( fpnew_pkg::FP32 ),
        .in_valid_i(fma_in_valid[i]),
        .in_ready_o(fma_in_ready[i]),
        .flush_i   ( 1'b0 ),
        .result_o  ( /* lane-i result */ ),
        .out_valid_o(fma_out_valid[i]),
        .out_ready_i('1),               //Our device is always ready for outputs
        .busy_o    (/* optional */ ),

        .tag_i     (/* lane-i tag */ ),
        .tag_o     ()
    );
end

//------------------------------------------------------------------------
// Single divider / sqrt unit
//------------------------------------------------------------------------
fpnew_top #(
    .Features      (Features),
    .Implementation(ImplDIV),
    .TagType       (tag_t)
) div_unit (
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
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

    .tag_i     (/* tag */ ),
    .tag_o     ()
);

endmodule