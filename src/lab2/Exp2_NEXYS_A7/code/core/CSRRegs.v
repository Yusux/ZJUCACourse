`timescale 1ns / 1ps

module CSRRegs(
    input clk, rst,
    input[11:0] raddr, waddr,
    input[31:0] wdata,
    input csr_w,
    input[1:0] csr_wsc_mode,

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

    output[31:0] rdata,
    output[31:0] mstatus,
    output[31:0] mtvec,
    output[31:0] mepc,
    output[31:0] mcause,
    output[31:0] mtval
);

    // You may need to modify this module for better efficiency
    
    reg[31:0] CSR [0:15];

    reg[1:0] privilege_level;

    // Address mapping. The address is 12 bits, but only 4 bits are used in this module.
    wire raddr_valid = raddr[11:7] == 5'h6 && raddr[5:3] == 3'h0;
    wire[3:0] raddr_map = (raddr[6] << 3) + raddr[2:0];
    wire waddr_valid = waddr[11:7] == 5'h6 && waddr[5:3] == 3'h0;
    wire[3:0] waddr_map = (waddr[6] << 3) + waddr[2:0];
    wire trap;
    wire[31:0] mstatus_next;
    wire[31:0] mepc_next;
    wire[31:0] mcause_next;
    wire[31:0] mtval_next;

    assign trap = (interrupt & mstatus[3]) | illegal_inst | l_access_fault | s_access_fault | ecall_m;

    // mstatus  0x300 0000 0
    // mtvec    0x305 0101 5
    // mepc     0x341 1001 9
    // mcause   0x342 1010 10
    // mtval    0x343 1011 11
    assign mstatus = CSR[0];
    assign mtvec = CSR[5];
    assign mepc = CSR[9];
    assign mcause = CSR[10];
    assign mtval = CSR[11];

    assign rdata = CSR[raddr_map];

    assign mstatus_next = mret ? {19'b0, 2'b11, 3'b0, 1'b1, 3'b0, mstatus[7], 3'b0}
                        : {19'b0, privilege_level, 3'b0, mstatus[3], 3'b0, 1'b0, 3'b0};
    assign mepc_next = interrupt ? epc_next
                     : epc_cur;
    assign mcause_next = interrupt ? 32'h8000000B
                       : illegal_inst ? 32'h00000002
                       : l_access_fault ? 32'h00000005
                       : s_access_fault ? 32'h00000007
                       : ecall_m ? 32'h0000000B
                       : 32'hFFFFFFFF;
    assign mtval_next = illegal_inst ? inst_cur
                      : (l_access_fault | s_access_fault) ? mem_addr_cur
                      : 32'h00000000;

    always@(posedge clk or posedge rst) begin
        if (rst) begin
			CSR[0] <= 32'h88;
			CSR[1] <= 0;
			CSR[2] <= 0;
			CSR[3] <= 0;
			CSR[4] <= 32'hfff;
			CSR[5] <= 32'h78;
			CSR[6] <= 0;
			CSR[7] <= 0;
			CSR[8] <= 0;
			CSR[9] <= 0;
			CSR[10] <= 0;
			CSR[11] <= 0;
			CSR[12] <= 0;
			CSR[13] <= 0;
			CSR[14] <= 0;
			CSR[15] <= 0;
            privilege_level <= 2'b11;
		end
        else if (trap) begin
            CSR[0] <= mstatus_next;
            CSR[9] <= mepc_next;
            CSR[10] <= mcause_next;
            CSR[11] <= mtval_next;
            privilege_level <= 2'b11;           // set privilege level to machine mode
        end
        else if (mret) begin
            CSR[0] <= mstatus_next;
            privilege_level <= mstatus[12:11];  // restore privilege level
        end
        else if (csr_w) begin
            case(csr_wsc_mode)
                2'b01: CSR[waddr_map] = wdata;                      // rw
                2'b10: CSR[waddr_map] = CSR[waddr_map] | wdata;     // rs
                2'b11: CSR[waddr_map] = CSR[waddr_map] & ~wdata;    // rc
                default: CSR[waddr_map] = wdata;
            endcase
        end
    end
endmodule