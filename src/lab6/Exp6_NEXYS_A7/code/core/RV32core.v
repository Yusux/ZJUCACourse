`timescale 1ns / 1ps
`include "CtrlDefine.vh"
module  RV32core(
        input debug_en,  // debug enable
        input debug_step,  // debug step clock
        input [6:0] debug_addr,  // debug address
        output[31:0] debug_data,  // debug data
        output[31:0] wb_addr,
        output[31:0] wb_data,
        output reg [31:0] clk_counter,
        input clk,  // main clock
        input rst,  // synchronous reset
        input interrupter  // interrupt source, for future use
    );

    wire debug_clk;
    wire[31:0] debug_regs;
    reg[31:0] Test_signal;
	assign debug_data = debug_addr[5] ? Test_signal : debug_regs;

    debug_clk clock(.clk(clk),.debug_en(debug_en),.debug_step(debug_step),.debug_clk(debug_clk));

    wire PC_EN_IF, IS_EN, RO_EN, FU_ALU_EN, FU_mem_EN, FU_mul_EN, FU_div_EN, FU_jump_EN;
    wire RegWrite_ctrl, ALUSrcA_ctrl, ALUSrcB_ctrl, mem_w_ctrl;
    wire[2:0] ImmSel_ctrl, bhw_ctrl, DatatoReg_ctrl;
    wire[3:0] ALUControl_ctrl;
    wire[4:0] Jump_ctrl;
    wire[4:0] rs1_addr_ctrl, rs2_addr_ctrl, rd_ctrl;
    wire[31:0] PC_ctrl, imm_ctrl;


    wire [31:0] PC_IF, next_PC_IF, PC_4_IF, inst_IF;

    wire[31:0]inst_IS, PC_IS, Imm_out_IS;

    wire[31:0]rs1_data_RO, rs2_data_RO, ALUA_RO, ALUB_RO;

    wire FU_ALU_finish, FU_mem_finish, FU_mul_finish, FU_div_finish, FU_jump_finish, is_jump_FU;
    wire[31:0]ALUout_FU, mem_data_FU, mulres_FU, divres_FU, PC_jump_FU, PC_wb_FU;

    wire[31:0]ALUout_WB, mem_data_WB, mulres_WB, divres_WB, PC_wb_WB, wt_data_WB;
    
    wire  ALU_use, MEM_use, MUL_use, DIV_use, JUMP_use;
    wire rs_rd_w_en, rs_rd_w_en_ALU, rs_rd_w_en_MEM, rs_rd_w_en_DIV, rs_rd_w_en_MUL, rs_rd_w_en_JUMP;
	wire  [4:0]R_addr_rd;
	wire [7:0] rs_num_rd, rs_num_A, rs_num_B, rs_num_rd_ALU, rs_num_rd_MEM, rs_num_rd_DIV, rs_num_rd_MUL, rs_num_rd_JUMP;
	wire [4:0] op_IS;
	
	wire [31:0] ALU_src1, ALU_src2, ALU_pc, MUL_src1, MUL_src2, MUL_pc, DIV_src1, DIV_src2, DIV_pc, JUMP_src1, JUMP_src2, JUMP_pc, JUMP_pc_cal, MEM_src1, MEM_src2, MEM_pc, JUMP_A, MEM_A;
	wire [4:0] ALU_op, JUMP_op, MEM_op;
	wire [7:0] ALU_rs_rd, MUL_rs_rd,DIV_rs_rd, JUMP_rs_rd, MEM_rs_rd;
	
	reg [31:0]ALUout_WB_, mem_data_WB_, mulres_WB_, divres_WB_, PC_wb_WB_, wt_data_WB_;
	
	// cdb broadcast, target RS entry and data
	wire [7:0] cdb_rs_num;
	wire [31:0] cdb_data;
	
	reg ctrl_stall=0;
    reg IS_flush=0;
    wire FU_stall;


    // IF
    assign PC_EN_IF = IS_EN | FU_jump_finish & is_jump_FU;

    REG32 REG_PC(.clk(debug_clk),.rst(rst),.CE(PC_EN_IF),.D(next_PC_IF),.Q(PC_IF));
    
    add_32 add_IF(.a(PC_IF),.b(32'd4),.c(PC_4_IF));

    MUX2T1_32 mux_IF(.I0(PC_4_IF),.I1(PC_jump_FU),.s(FU_jump_finish & is_jump_FU),.o(next_PC_IF));

    ROM_D inst_rom(.a(PC_IF[10:2]),.spo(inst_IF));


    //Issue
    REG_IF_IS reg_IF_IS(.clk(debug_clk),.rst(rst),.EN(IS_EN),
        .flush(1'b0),.PCOUT(PC_IF),.IR(inst_IF),
        .IR_IS(inst_IS),.PCurrent_IS(PC_IS));
    
    ImmGen imm_gen(.ImmSel(ImmSel_ctrl),.inst_field(inst_IS),.Imm_out(Imm_out_IS));

    CtrlUnit ctrl(
        .inst(inst_IS),
        
        .ImmSel(ImmSel_ctrl),
        .rs1_ctrl(rs1_addr_ctrl),.rs2_ctrl(rs2_addr_ctrl), .dst_ctrl(rd_ctrl) ,
        .ALU_use_PC(ALUSrcA_ctrl),.ALU_use_imm(ALUSrcB_ctrl),
        
        .op(op_IS),
        .ALU_use(ALU_use), .MEM_use(MEM_use), .MUL_use(MUL_use), .DIV_use(DIV_use), .JUMP_use(JUMP_use)
    );

    // u can integrate RAT into registers
    assign rs_rd_w_en_ALU = op_IS == `ALU_ADD       ||
                            op_IS == `ALU_SUB       ||
                            op_IS == `ALU_AND       ||
                            op_IS == `ALU_OR        ||
                            op_IS == `ALU_XOR       ||
                            op_IS == `ALU_SLL       ||
                            op_IS == `ALU_SRL       ||
                            op_IS == `ALU_SLT       ||
                            op_IS == `ALU_SLTU      ||
                            op_IS == `ALU_SRA       ||
                            op_IS == `ALU_ADDI      ||
                            op_IS == `ALU_ANDI      ||
                            op_IS == `ALU_ORI       ||
                            op_IS == `ALU_XORI      ||
                            op_IS == `ALU_SLLI      ||
                            op_IS == `ALU_SRLI      ||
                            op_IS == `ALU_SLTI      ||
                            op_IS == `ALU_SLTIU     ||
                            op_IS == `ALU_SRAI      ||
                            op_IS == `ALU_AUIPC     ||
                            op_IS == `ALU_LUI       ;
    assign rs_rd_w_en_MEM = op_IS == `MEM_LB        ||
                            op_IS == `MEM_LH        ||
                            op_IS == `MEM_LW        ||
                            op_IS == `MEM_LBU       ||
                            op_IS == `MEM_LHU       ;
    assign rs_rd_w_en_DIV = op_IS == `DIV_DIV       ||
                            op_IS == `DIV_DIVU      ||
                            op_IS == `DIV_REM       ||
                            op_IS == `DIV_REMU      ;
    assign rs_rd_w_en_MUL = op_IS == `MUL_MUL       ||
                            op_IS == `MUL_MULH      ||
                            op_IS == `MUL_MULHU     ||
                            op_IS == `MUL_MULHSU    ;
    assign rs_rd_w_en_JUMP = op_IS == `JUMP_JAL     ||
                             op_IS == `JUMP_JALR    ;
    assign rs_rd_w_en = ALU_use & rs_rd_w_en_ALU    |
                        MEM_use & rs_rd_w_en_MEM    |
                        DIV_use & rs_rd_w_en_DIV    |
                        MUL_use & rs_rd_w_en_MUL    |
                        JUMP_use & rs_rd_w_en_JUMP  ;

    Regs register(.clk(debug_clk),.rst(rst),
    
       // for tomasulo IS
	   .rs_rd_w_en(rs_rd_w_en), // does this instr need to write reg? If so, we need to update RAT
	   .R_addr_rd(rd_ctrl),    // target reg
	   .rs_num_rd(rs_num_rd),  // free RS entry, RAT[target reg] = free RS entry
	   .rs_num_A(rs_num_A),    // Qj
	   .rs_num_B(rs_num_B),    // Qk
        
        // cdb broadcast
        .cdb_rs_num(cdb_rs_num), 
		.cdb_data(cdb_data),
        
        .R_addr_A(rs1_addr_ctrl),.rdata_A(rs1_data_RO),
        .R_addr_B(rs2_addr_ctrl),.rdata_B(rs2_data_RO),
//        .L_S(RegWrite_ctrl),.Wt_addr(rd_ctrl),.Wt_data(wt_data_WB),   // cdb broadcast will update register, not here
        .Debug_addr(debug_addr[4:0]),.Debug_regs(debug_regs));

    MUX2T1_32 mux_imm_ALU_RO_A(.I0(rs1_data_RO),.I1(PC_IS),.s(ALUSrcA_ctrl),.o(ALUA_RO));

    MUX2T1_32 mux_imm_ALU_RO_B(.I0(rs2_data_RO),.I1(Imm_out_IS),.s(ALUSrcB_ctrl),.o(ALUB_RO));


    // if u don't implement ROB, when encountering a jump instr, just stall as u did in lab5; for structure hazard, stall as well  
    always @(posedge debug_clk or posedge rst) begin
        if (rst) begin
            IS_flush <= 0;
        end
        else if (FU_jump_finish & is_jump_FU) begin
            IS_flush <= 1;
        end
        else begin
            IS_flush <= 0;
        end
    end

    always @(posedge debug_clk or posedge rst) begin
        if (rst) begin
            ctrl_stall <= 0;
        end
        else begin
            if (RO_EN & JUMP_use) begin
                ctrl_stall <= 1;
            end
            else if (FU_jump_finish) begin
                ctrl_stall <= 0;
            end
        end
    end

    assign FU_stall = (ALU_use | MEM_use | MUL_use | DIV_use | JUMP_use) && (rs_num_rd == 8'b0);
    // always @(posedge debug_clk or posedge rst) begin
    //     if (rst) begin
    //         FU_stall <= 0;
    //     end
    //     else begin
    //         if (ALU_use | MEM_use | MUL_use | DIV_use | JUMP_use && rs_num_rd == 8'b0) begin
    //             FU_stall <= 1;
    //         end
    //         else begin
    //             FU_stall <= 0;
    //         end
    //     end
    // end

    assign IS_EN = IS_flush | ~FU_stall & ~ctrl_stall;
    assign RO_EN = ~IS_flush & ~FU_stall & ~ctrl_stall;
         
    // allocated free RS entry, if any
    assign rs_num_rd =  {8{ALU_use}}          &     rs_num_rd_ALU |
                        {8{MEM_use}}          &     rs_num_rd_MEM |
                        {8{DIV_use}}          &     rs_num_rd_DIV |
                        {8{MUL_use}}          &     rs_num_rd_MUL |
                        {8{JUMP_use}}         &     rs_num_rd_JUMP ;
            

    // RS(��) and LSQ(TBD)
    RS #(.FU(`FU_ALU), .num(3)) rs_alu(
        .clk(debug_clk),
	    .rst(rst),
		
		.selected(ALU_use & RO_EN),
	    .free_rs(rs_num_rd_ALU),
	    .op(op_IS),
		.Qj(rs_num_A),
		.Qk(rs_num_B),
		.Vj(ALUA_RO),
		.Vk(ALUB_RO),
		.A(0),
		.pc_IS(PC_IS),
		
		.en_FU(FU_ALU_EN),
	    .vj(ALU_src1),
	    .vk(ALU_src2),
		.op_out(ALU_op),
		.A_o(),
		.pc_FU(ALU_pc),
		
		
		.cdb_rs_rd(ALU_rs_rd),
		.cdb_rs_num(cdb_rs_num),
		.cdb_data(cdb_data),
		
		
		.pc_debug()
    );

    RS #(.FU(`FU_MEM), .num(1)) rs_mem(
        .clk(debug_clk),
	    .rst(rst),
		
		.selected(MEM_use & RO_EN),
	    .free_rs(rs_num_rd_MEM),
	    .op(op_IS),
		.Qj(rs_num_A),
		.Qk(rs_num_B),
		.Vj(rs1_data_RO),
		.Vk(rs2_data_RO),
		.A(Imm_out_IS),
		.pc_IS(PC_IS),
		
		.en_FU(FU_mem_EN),
	    .vj(MEM_src1),
	    .vk(MEM_src2),
		.op_out(MEM_op),
		.A_o(MEM_A),
		.pc_FU(MEM_pc),
		
		
		.cdb_rs_rd(MEM_rs_rd),
		.cdb_rs_num(cdb_rs_num),
		.cdb_data(cdb_data),
		
		
		.pc_debug()
    );

    RS #(.FU(`FU_MUL), .num(3)) rs_mul(
        .clk(debug_clk),
	    .rst(rst),
		
		.selected(MUL_use & RO_EN),
	    .free_rs(rs_num_rd_MUL),
	    .op(op_IS),
		.Qj(rs_num_A),
		.Qk(rs_num_B),
		.Vj(rs1_data_RO),
		.Vk(rs2_data_RO),
		.A(0),
		.pc_IS(PC_IS),
		
		.en_FU(FU_mul_EN),
	    .vj(MUL_src1),
	    .vk(MUL_src2),
		.op_out(),
		.A_o(),
		.pc_FU(MUL_pc),
		
		
		.cdb_rs_rd(MUL_rs_rd),
		.cdb_rs_num(cdb_rs_num),
		.cdb_data(cdb_data),
		
		
		.pc_debug()
    );

    RS #(.FU(`FU_DIV), .num(3)) rs_div(
        .clk(debug_clk),
	    .rst(rst),
		
		.selected(DIV_use & RO_EN),
	    .free_rs(rs_num_rd_DIV),
	    .op(op_IS),
		.Qj(rs_num_A),
		.Qk(rs_num_B),
		.Vj(rs1_data_RO),
		.Vk(rs2_data_RO),
		.A(0),
		.pc_IS(PC_IS),
		
		.en_FU(FU_div_EN),
	    .vj(DIV_src1),
	    .vk(DIV_src2),
		.op_out(),
		.A_o(),
		.pc_FU(DIV_pc),
		
		
		.cdb_rs_rd(DIV_rs_rd),
		.cdb_rs_num(cdb_rs_num),
		.cdb_data(cdb_data),
		
		
		.pc_debug()
    );

    RS #(.FU(`FU_JUMP), .num(1)) rs_jump(
        .clk(debug_clk),
	    .rst(rst),
		
		.selected(JUMP_use & RO_EN),
	    .free_rs(rs_num_rd_JUMP),
	    .op(op_IS),
		.Qj(rs_num_A),
		.Qk(rs_num_B),
		.Vj(rs1_data_RO),
		.Vk(rs2_data_RO),
		.A(Imm_out_IS),
		.pc_IS(PC_IS),
		
		.en_FU(FU_jump_EN),
	    .vj(JUMP_src1),
	    .vk(JUMP_src2),
		.op_out(JUMP_op),
		.A_o(JUMP_A),
		.pc_FU(JUMP_pc),
		
		
		.cdb_rs_rd(JUMP_rs_rd),
		.cdb_rs_num(cdb_rs_num),
		.cdb_data(cdb_data),
		
		
		.pc_debug()
    );
    
   
    // For memory access instrs, to ensure in-order memory access:
    //  if u use RS defined in this project, alloc one entry only
    //  u can also implement load store queue
    //  BTW, u can also implement out-of-order memory access (orz 
    

    // FU, just those in lab5
    assign ALUControl_ctrl = ALU_op == `ALU_AUIPC ? 4'b0001 : ALU_op[3:0];
    FU_ALU alu(.clk(debug_clk),.EN(FU_ALU_EN & ~done_record[1]),.finish(FU_ALU_finish),
        .ALUControl(ALUControl_ctrl),.ALUA(ALU_src1),.ALUB(ALU_src2),.res(ALUout_FU),
        .zero(),.overflow());

    assign mem_w_ctrl = MEM_op[0];
    assign bhw_ctrl = MEM_op[3:1];
    FU_mem mem(.clk(debug_clk),.EN(FU_mem_EN & ~done_record[2]),.finish(FU_mem_finish),
        .mem_w(mem_w_ctrl),.bhw(bhw_ctrl),.rs1_data(MEM_src1),.rs2_data(MEM_src2),
        .imm(MEM_A),.mem_data(mem_data_FU));

    FU_mul mu(.clk(debug_clk),.EN(FU_mul_EN & ~done_record[3]),.finish(FU_mul_finish),
        .A(MUL_src1),.B(MUL_src2),.res(mulres_FU));

    FU_div du(.clk(debug_clk),.EN(FU_div_EN & ~done_record[4] & ~done_record[1]),.finish(FU_div_finish),
        .A(DIV_src1),.B(DIV_src2),.res(divres_FU));

    FU_jump ju(.clk(debug_clk),.EN(FU_jump_EN & ~done_record[5]),.finish(FU_jump_finish),
        .JALR(JUMP_op[4]),.cmp_ctrl(JUMP_op[3:0]),.rs1_data(JUMP_src1),.rs2_data(JUMP_src2),
        .imm(JUMP_A),.PC(JUMP_pc),.PC_jump(PC_jump_FU),.PC_wb(PC_wb_FU),.is_jump(is_jump_FU));


    // CDB broadcast 
    reg [5:1] done_record; // similar to lab5, when multi-FU finish, we need to choose one and delay others 

    always @(posedge debug_clk or posedge rst) begin
        if (rst) begin
            done_record <= 0;
        end 
        else begin
            // assign done_record
            if (FU_ALU_finish) begin
                done_record[1] <= 1;
            end
            if (FU_mem_finish) begin
                done_record[2] <= 1;
            end
            if (FU_mul_finish) begin
                done_record[3] <= 1;
            end
            if (FU_div_finish) begin
                done_record[4] <= 1;
            end
            if (FU_jump_finish) begin
                done_record[5] <= 1;
            end

            // choose one to broadcast
            if (done_record[1]) begin
                done_record[1] <= 0;
            end else if (done_record[2]) begin
                done_record[2] <= 0;
            end else if (done_record[3]) begin
                done_record[3] <= 0;
            end else if (done_record[4]) begin
                done_record[4] <= 0;
            end else if (done_record[5]) begin
                done_record[5] <= 0;
            end
        end
    end
    wire [31:0]cdb_pc;  // for debug
    
    assign cdb_data = done_record[1] ? ALUout_FU :
                      done_record[2] ? mem_data_FU :
                      done_record[3] ? mulres_FU :
                      done_record[4] ? divres_FU :
                      done_record[5] ? PC_wb_FU :
                      0;
    assign cdb_rs_num = done_record[1] ? ALU_rs_rd :
                        done_record[2] ? MEM_rs_rd :
                        done_record[3] ? MUL_rs_rd :
                        done_record[4] ? DIV_rs_rd :
                        done_record[5] ? JUMP_rs_rd :
                        0;
    assign cdb_pc = done_record[1] ? ALU_pc :
                    done_record[2] ? MEM_pc :
                    done_record[3] ? MUL_pc :
                    done_record[4] ? DIV_pc :
                    done_record[5] ? JUMP_pc :
                    0;


    assign wb_addr = cdb_pc;
    assign wb_data = cdb_data;

    always @(posedge debug_clk) begin
        if (rst) begin
            clk_counter <= 0;
        end else begin
            clk_counter <= clk_counter + 32'd1;
        end
    end



endmodule