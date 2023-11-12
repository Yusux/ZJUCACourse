`timescale 1ns / 1ps

module ExceptionUnit(
    input clk, rst,
    input csr_rw_in,
    // write/set/clear (funct bits from instruction)
    input[1:0] csr_wsc_mode_in,
    input csr_w_imm_mux,
    input[11:0] csr_rw_addr_in,
    input[31:0] csr_w_data_reg,
    input[4:0] csr_w_data_imm,
    output[31:0] csr_r_data_out,

    input interrupt,
    input illegal_inst,
    input l_access_fault,
    input s_access_fault,
    input ecall_m,

    input mret,

    input[31:0] epc_cur,
    input[31:0] epc_next,
    input[31:0] inst_cur,
    input[31:0] mem_addr_cur,
    output[31:0] PC_redirect,
    output redirect_mux,

    output reg_FD_flush, reg_DE_flush, reg_EM_flush, reg_MW_flush, 
    output RegWrite_cancel,
    output MemWrite_cancel
);
    // According to the diagram, design the Exception Unit
    // You can modify any code in this file if needed!
    wire[31:0] csr_wdata;    // csr write data

    wire[31:0] mstatus;
    wire[31:0] mtvec;
    wire[31:0] mepc;
    wire[31:0] mcause;
    wire[31:0] mtval;

    wire[31:0] csr_rdata;
    wire[31:0] mret_pc;

    wire trap;
    wire is_flush;

    assign csr_r_data_out = csr_rdata;
    assign csr_wdata = csr_w_imm_mux ? {27'b0, csr_w_data_imm} : csr_w_data_reg;

    assign trap = (interrupt & mstatus[3]) | illegal_inst | l_access_fault | s_access_fault | ecall_m;
    assign is_flush = trap | mret;

    assign mret_pc = mcause[31] ? mepc-4 : mepc;
    assign PC_redirect = mret ? mret_pc : mtvec;
    assign redirect_mux = is_flush;
    assign reg_FD_flush = is_flush;
    assign reg_DE_flush = is_flush;
    assign reg_EM_flush = is_flush;
    assign reg_MW_flush = is_flush;
    assign RegWrite_cancel = illegal_inst | l_access_fault | s_access_fault; // interrupt should not cancel RegWrite
    assign MemWrite_cancel = trap;      // all trap should cancel MemWrite

    CSRRegs csr(
        .clk(clk),
        .rst(rst),
        .raddr(csr_rw_addr_in),
        .waddr(csr_rw_addr_in),
        .wdata(csr_wdata),
        .csr_w(csr_rw_in),
        .csr_wsc_mode(csr_wsc_mode_in),
        .interrupt(interrupt),
        .illegal_inst(illegal_inst),
        .l_access_fault(l_access_fault),
        .s_access_fault(s_access_fault),
        .ecall_m(ecall_m),

        .mret(mret),

        .epc_cur(epc_cur),
        .epc_next(epc_next),
        .inst_cur(inst_cur),
        .mem_addr_cur(mem_addr_cur),
        .rdata(csr_rdata),
        .mstatus(mstatus),
        .mtvec(mtvec),
        .mepc(mepc),
        .mcause(mcause),
        .mtval(mtval)
    );
endmodule
