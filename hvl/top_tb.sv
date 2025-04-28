module top_tb;

    // Clock and reset
    logic clk;
    logic rst_n;

    // DUT Inputs
    logic [31:0] fprti_regs [0:15];
    logic input_valid;

    // DUT Outputs
    logic [31:0] return_value;
    logic output_valid;

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // DUT instantiation
    plane_ray_int dut (
        .clk(clk),
        .rst_n(rst_n),
        .fprti_regs_i(fprti_regs),
        .input_valid_i(input_valid),
        .return_o(return_value),
        .output_valid_o(output_valid)
    );

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, "+all");
        end
    end

    // Test Stimulus
    initial begin
        // Initialization
        input_valid = 0;
        for (int i = 0; i < 16; i++) begin
            fprti_regs[i] = 32'h0;
        end

        // Wait for reset
        @(posedge rst_n);
        #10;

        // Apply sample input
        // fprti_regs[0]  = 32'h3f000000; // p0.x = 0.5
        // fprti_regs[1]  = 32'h3f000000; // p0.y = 0.5
        // fprti_regs[2]  = 32'h3f000000; // p0.z = 0.5

        // fprti_regs[3]  = 32'h3f800000; // p1.x = 1.0
        // fprti_regs[4]  = 32'h00000000; // p1.y = 0.0
        // fprti_regs[5]  = 32'h00000000; // p1.z = 0.0

        // fprti_regs[6]  = 32'h00000000; // p2.x = 0.0
        // fprti_regs[7]  = 32'h3f800000; // p2.y = 1.0
        // fprti_regs[8]  = 32'h00000000; // p2.z = 0.0

        // fprti_regs[0]  = 32'h3F000000; // p0.x = 0.5
        // fprti_regs[1]  = 32'h3F000000; // p0.y = 0.5
        // fprti_regs[2]  = 32'h3F800000; // p0.z = 1.0

        // fprti_regs[3]  = 32'h40000000; // p1.x = 2.0
        // fprti_regs[4]  = 32'h40000000; // p1.y = 2.0
        // fprti_regs[5]  = 32'h40200000; // p1.z = 2.5

        // fprti_regs[6]  = 32'h3FC00000; // p2.x = 1.5
        // fprti_regs[7]  = 32'h3F000000; // p2.y = 0.5
        // fprti_regs[8]  = 32'h3F800000; // p2.z = 1.0

        // p0 (Base point)
        fprti_regs[0]  = 32'h3F000000; // p0.x = 0.5
        fprti_regs[1]  = 32'h3F19999A; // p0.y = 0.6
        fprti_regs[2]  = 32'h3F333333; // p0.z = 0.7

        // p1 (First triangle point)
        fprti_regs[3]  = 32'h3F800000; // p1.x = 1.0
        fprti_regs[4]  = 32'h40000000; // p1.y = 2.0
        fprti_regs[5]  = 32'h40400000; // p1.z = 3.0

        // p2 (Second triangle point)
        fprti_regs[6]  = 32'h40800000; // p2.x = 4.0
        fprti_regs[7]  = 32'h40A00000; // p2.y = 5.0
        fprti_regs[8]  = 32'h40C00000; // p2.z = 6.0

        // 32'h3F800000; // p2.x - p0.x = 1.0
        // 32'h00000000; // p2.y - p0.y = 0.0
        // 32'h00000000; // p2.z - p0.z = 0.0
        // 32'h3FC00000; // p1.x - p0.x = 1.5
        // 32'h3FC00000; // p1.y - p0.y = 1.5
        // 32'h3FC00000; // p1.z - p0.z = 1.5


        fprti_regs[9]  = 32'h3f000000; // r0.x = 0.5
        fprti_regs[10] = 32'h3f000000; // r0.y = 0.5
        fprti_regs[11] = 32'h00000000; // r0.z = 0.0

        fprti_regs[12] = 32'h00000000; // rd.x = 0.0
        fprti_regs[13] = 32'h00000000; // rd.y = 0.0
        fprti_regs[14] = 32'h3f800000; // rd.z = 1.0

        // Give input
        input_valid = 1;
        #10;
        input_valid = 0;

        // Wait for output
        wait (output_valid == 1);
        #5;

        // Display result
        $display("Return Value (Hex) = %h", return_value);

        // End simulation
        #50;
        $finish;
    end

endmodule