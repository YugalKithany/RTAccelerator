module triangle_vector_int
(
    input  logic                     clk,
    input  logic                     rst_n,

    input  logic [31:0]              fprti_regs [15],
    
    output logic [31:0]              return_o
);

logic [31:0] normal_vector [3];
logic [31:0] intersection_pt [3];
logic [31:0] intermediate_vector1[3];
logic [31:0] intermediate_vector2[3]; 

typedef enum logic [2:0] {
    IDLE,                   // idle stage
    NORMAL,                 // n = AB x AC (6 multipliers)
    PLANE_INT_DOT,          // (p - r_o) . n, r_d . n (6 multipliers)
    PLANE_INT_DIV,          // t = x / y (3 dividers)
    NO_INT,                 // no intersection
    TRI_INT_CROSS_1,        // (p_2 - p_o) x n (6 multipliers)
    TRI_INT_CROSS_2,        // (p_1 - p_o) x n (6 multipliers)
    TRI_INT_DENUM,          // (a1.p1-p0),(a2.p2-p0) (6 multipliers)
    TRI_INT_DIV,            // e1 = a1 / (a1.p1-p0), e2 = a2 / (a2.p2-p0) (6 dividers)
    TRI_INT_DOT             // b1 = e1 . (p - p0), b2 = e2 . (p - p0) (6 multipliers)
}  plane_ray_state_t;

endmodule