`timescale 1ns/1ps

module top_tb;
  // Clock and Reset Signals
  logic clk;
  logic rst_n;

  // Define number of FPRTI registers
  localparam NUM_FPRTI_REGS = 15; // 9 (triangle) + 3 (origin) + 3 (direction)
  localparam NUM_TESTS = 100;

  // DUT I/O Signals
  logic [31:0] fprti_regs_i [NUM_FPRTI_REGS];
  logic        input_valid_i;
  logic [31:0] return_o;
  logic        output_valid_o;

  // Instantiate DUT
  plane_ray_int #(
    .NUM_FPRTI_REGS(NUM_FPRTI_REGS)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .fprti_regs_i(fprti_regs_i),
    .input_valid_i(input_valid_i),
    .return_o(return_o),
    .output_valid_o(output_valid_o)
  );

  // Testbench Variables
  shortreal triangle[9];
  shortreal ray_origin[3];
  shortreal ray_dir[3];
  int       expected_result;

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
  end

  // Reset Generation
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // Main Test Sequence
  initial begin
    int passed = 0;
    int total = NUM_TESTS;
    
    init_rand();
    @(posedge rst_n);

    for (int i = 0; i < NUM_TESTS; i++) begin
      // Generate new test case
      generate_test_case(triangle, ray_origin, ray_dir, expected_result);

      // Pack data into registers
      foreach(triangle[j]) fprti_regs_i[j] = $shortrealtobits(triangle[j]);
      foreach(ray_origin[j]) fprti_regs_i[9+j] = $shortrealtobits(ray_origin[j]);
      foreach(ray_dir[j]) fprti_regs_i[12+j] = $shortrealtobits(ray_dir[j]);

      // Trigger DUT
      input_valid_i = 1;
      @(posedge clk);
      input_valid_i = 0;

      // Wait for result
      wait(output_valid_o);
      @(negedge clk);

      // Check and count results
      if (return_o == expected_result) begin
        passed++;
        $display("Test %0d: PASS", i);
      end
      else begin
        $display("Test %0d: FAIL (EXP: %0d GOT: %0d)", i, expected_result, return_o);
      end
    end

    // Final report
    $display("\n=== TEST SUMMARY ===");
    $display("Total tests : %0d", total);
    $display("Passed tests: %0d", passed);
    $display("Failed tests: %0d", total - passed);
    $display("Success rate: %0.2f%%", (passed * 100.0) / total);
    $finish();
  end

  // DPI-C Imports
  import "DPI-C" function void init_rand();
  import "DPI-C" function void generate_test_case(
    output shortreal triangle[9],
    output shortreal ray_origin[3],
    output shortreal ray_dir[3],
    output int result
  );
endmodule
