import "DPI-C" function string getenv(input string env_name);

module top_tb;

    timeunit 1ps;
    timeprecision 1ps;

    int clock_half_period_ps = getenv("ECE411_CLOCK_PERIOD_PS").atoi() / 2;

    bit clk;
    always #(clock_half_period_ps) clk = ~clk;

    bit rst;

    int timeout = 1000000000; // in cycles, change according to your needs
    int cpu_timeout = 100;

    mem_itf_banked mem_itf(.*);
    dram_w_burst_frfcfs_controller mem(.itf(mem_itf));

    mon_itf #(.CHANNELS(8)) mon_itf(.*);
    monitor #(.CHANNELS(8)) monitor(.itf(mon_itf));

    
    cpu dut(
        .clk            (clk),
        .rst            (rst),

        .bmem_addr  (mem_itf.addr  ),
        .bmem_read  (mem_itf.read  ),
        .bmem_write (mem_itf.write ),
        .bmem_wdata (mem_itf.wdata ),
        .bmem_ready (mem_itf.ready ),
        .bmem_raddr (mem_itf.raddr ),
        .bmem_rdata (mem_itf.rdata ),
        .bmem_rvalid(mem_itf.rvalid)
    );
    

    `include "rvfi_reference.svh"

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, "+all");
        end
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;
    end

    always @(posedge clk) begin
        for (int unsigned i = 0; i < 8; ++i) begin
            if (mon_itf.halt[i]) begin
                $finish;
            end
        end
        /*
        if (timeout == 0) begin
            $error("TB Error: Timed out");
            $fatal;
        end
        */
        
        if (mon_itf.error != 0) begin
            repeat (5) @(posedge clk);
            $fatal;
        end
        if (mem_itf.error != 0) begin
            repeat (5) @(posedge clk);
            $fatal;
        end
        timeout <= timeout - 1;
    end

    final begin
        $display("Final Branch Taken Count: %0d", dut.ALU_i.branch_taken_counter);
        $display("Total Branch Instructions Count: %0d", dut.ALU_i.total_branches_counter);
        $display("Branch Misprediction Count: %0d", dut.ALU_i.misprediction_counter);
        $display("Branch Predictor Accuracy: %f%%", ( (dut.ALU_i.total_branches_counter - dut.ALU_i.misprediction_counter) * 1.0 / dut.ALU_i.total_branches_counter ) * 100.0
);
    end

endmodule
