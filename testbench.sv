module testbench;
  import "DPI-C" function void init_rand();
  import "DPI-C" function void generate_test_case(
    output shortreal triangle[9],
    output shortreal ray_origin[3],
    output shortreal ray_dir[3],
    output int result
  );

  // Example DUT signals
  shortreal tb_triangle[9];
  shortreal tb_ray_origin[3];
  shortreal tb_ray_dir[3];
  int       tb_expected_result;

  initial begin
    // Initialize randomization
    init_rand();

    // Generate test case
    generate_test_case(tb_triangle, tb_ray_origin, tb_ray_dir, tb_expected_result);

    // Print values
    $display("Triangle:");
    for (int i = 0; i < 9; i += 3) begin
      $display("  (%0.3f, %0.3f, %0.3f)", 
               tb_triangle[i], tb_triangle[i+1], tb_triangle[i+2]);
    end

    $display("Ray Origin: (%0.3f, %0.3f, %0.3f)",
             tb_ray_origin[0], tb_ray_origin[1], tb_ray_origin[2]);
    $display("Ray Direction: (%0.3f, %0.3f, %0.3f)",
             tb_ray_dir[0], tb_ray_dir[1], tb_ray_dir[2]);
    $display("Expected Result: %0d", tb_expected_result);

    // Here you would typically:
    // 1. Drive these values into your DUT
    // 2. Read the DUT's output
    // 3. Compare with tb_expected_result
    // 4. Report verification status

    $finish();
  end
endmodule