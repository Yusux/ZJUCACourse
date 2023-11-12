`timescale 1ns / 1ps

module core_sim;
    reg clk, rst;

    reg interrupter;

    RV32core core(
        .debug_en(1'b0),
        .debug_step(1'b0),
        .debug_addr(7'b0),
        .debug_data(),
        .clk(clk),
        .rst(rst),
        .interrupter(interrupter)
    );

    initial begin
        clk = 0;
        rst = 1;
        interrupter = 0;
        #2 rst = 0;
        #30 interrupter = 1;
        #2 interrupter = 0;
        #38 interrupter = 1;
        #2 interrupter = 0;
    end
    always #1 clk = ~clk;

endmodule