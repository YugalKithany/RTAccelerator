package plane_ray_int_defines;

import fpnew_pkg::*;

typedef logic [4:0] tag_t;

//---------------------------------------------------------------------
// Feature set (single-precision only, no vectors, translation, double)
//---------------------------------------------------------------------
localparam fpu_features_t Features = '{
    Width:         32,
    EnableVectors: 1'b0,
    EnableNanBox:  1'b0,
    FpFmtMask:     5'b10000,
    IntFmtMask:    4'b0000
};

//---------------------------------------------------------------------
// Implementation tables
//---------------------------------------------------------------------
// 2-cycle pipeline in each FMA slice, 4-cycle divider
localparam fpu_implementation_t ImplFMA = '{
      PipeRegs:   '{default: 2},
      UnitTypes:  '{
                  '{default: PARALLEL},   // ADDMUL
                  '{default: DISABLED},   // DIVSQRT
                  '{default: DISABLED},   // NONCOMP
                  '{default: DISABLED}},  // CONV
      PipeConfig: DISTRIBUTED
};
localparam fpu_implementation_t ImplDIV = '{
      PipeRegs:   '{default: 4},
      UnitTypes:  '{
                  '{default: DISABLED},   // ADDMUL
                  '{default: PARALLEL},   // DIVSQRT
                  '{default: DISABLED},   // NONCOMP
                  '{default: DISABLED}},  // CONV
      PipeConfig: DISTRIBUTED
};

endpackage