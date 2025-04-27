module tb_plane_ray_int;

    // Clock and reset
    logic clk;
    logic rst_n;

    // DUT I/O
    logic start;
    logic [31:0] ray_p0 [2:0];
    logic [31:0] ray_dir [2:0];
    logic [31:0] plane_p0 [2:0];
    logic [31:0] plane_nrm [2:0];

    logic busy;
    logic valid;
    logic [31:0] t;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Reset sequence
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // DUT instantiation
    plane_ray_int dut (
        .*
    );

    // VCD dump
    initial begin
        $dumpfile("tb_plane_ray_int.vcd");
        $dumpvars(0, tb_plane_ray_int);
    end

    // Test stimulus
    initial begin
        // Wait for reset
        @(posedge rst_n);

        // Initialize inputs
        start = 0;
        ray_p0[0] = 32'h00000000; // 0.0f
        ray_p0[1] = 32'h00000000;
        ray_p0[2] = 32'h00000000;

        ray_dir[0] = 32'h3f800000; // 1.0f
        ray_dir[1] = 32'h00000000;
        ray_dir[2] = 32'h00000000;

        plane_p0[0] = 32'h3f800000; // 1.0f
        plane_p0[1] = 32'h00000000;
        plane_p0[2] = 32'h00000000;

        plane_nrm[0] = 32'h3f800000; // 1.0f
        plane_nrm[1] = 32'h00000000;
        plane_nrm[2] = 32'h00000000;

        // Small wait
        #10;
        
        // Start the computation
        start = 1;
        #10;
        start = 0;

        // Wait for computation to complete
        wait (valid);

        // Display the output
        $display("Intersection t (hex) = %h", t);
        //$display("Intersection t (float) = %0f", $bitstoshortreal(t)); // <-- Only use if Verilator supports it, otherwise comment

        // Finish simulation
        #20;
        $finish;
    end

endmodule
