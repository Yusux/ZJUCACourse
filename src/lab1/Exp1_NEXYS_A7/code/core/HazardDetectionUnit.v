`timescale 1ps/1ps

module HazardDetectionUnit(
    input clk,
    input Branch_ID, rs1use_ID, rs2use_ID,
    input[1:0] hazard_optype_ID,
    input[4:0] rd_EXE, rd_MEM, rs1_ID, rs2_ID, rs2_EXE,
    output PC_EN_IF, reg_FD_EN, reg_FD_stall, reg_FD_flush,
        reg_DE_EN, reg_DE_flush, reg_EM_EN, reg_EM_flush, reg_MW_EN,
    output forward_ctrl_ls,
    output[1:0] forward_ctrl_A, forward_ctrl_B
);
    parameter hazard_optype_ALU = 2'b01;
    parameter hazard_optype_LOAD = 2'b10;
    parameter hazard_optype_STORE = 2'b11;

    reg[1:0] hazard_optype_EXE, hazard_optype_MEM;

    always@(posedge clk) begin
        hazard_optype_MEM <= hazard_optype_EXE;
        hazard_optype_EXE <= hazard_optype_ID & {2{~reg_DE_flush}};
    end

    wire rs1_forward_1 = rs1use_ID                             &&   // judge whether rs1 is used
                         rs1_ID                                &&   // judge whether it is x0
                         rs1_ID == rd_EXE                      &&   // judge whether rs1 is the destination register of EX
                         hazard_optype_EXE == hazard_optype_ALU ;   // judge whether EX is ALU operation
    wire rs1_forward_2 = rs1use_ID                             &&
                         rs1_ID                                &&
                         rs1_ID == rd_MEM                      &&
                         hazard_optype_MEM == hazard_optype_ALU ;
    wire rs1_forward_3 = rs1use_ID                             &&
                         rs1_ID                                &&
                         rs1_ID == rd_MEM                      &&
                         hazard_optype_MEM == hazard_optype_LOAD; 
    wire rs2_forward_1 = rs2use_ID                             &&
                         rs2_ID                                &&
                         rs2_ID == rd_EXE                      &&
                         hazard_optype_EXE == hazard_optype_ALU ;
    wire rs2_forward_2 = rs2use_ID                             &&
                         rs2_ID                                &&
                         rs2_ID == rd_MEM                      &&
                         hazard_optype_MEM == hazard_optype_ALU ;
    wire rs2_forward_3 = rs2use_ID                             &&
                         rs2_ID                                &&
                         rs2_ID == rd_MEM                      &&
                         hazard_optype_MEM == hazard_optype_LOAD;
    
    assign forward_ctrl_A = rs1_forward_1 ?  2'd1
                          : rs1_forward_2 ?  2'd2
                          : rs1_forward_3 ?  2'd3
                          : 2'b0 ;
    assign forward_ctrl_B = rs2_forward_1 ?  2'd1
                          : rs2_forward_2 ?  2'd2
                          : rs2_forward_3 ?  2'd3
                          : 2'b0 ;
    
    assign forward_ctrl_ls = rs2_EXE                                 &&
                             rs2_EXE == rd_MEM                       &&
                             hazard_optype_EXE == hazard_optype_STORE&&
                             hazard_optype_MEM == hazard_optype_LOAD ;

    wire rs1_stall = rs1use_ID                             &&   // judge whether rs1 is used
                     rs1_ID && rs1_ID == rd_EXE            &&   // judge whether rs1 is the destination register of EX
                     hazard_optype_EXE == hazard_optype_LOAD;   // judge whether EX is LOAD operation
    wire rs2_stall = rs2use_ID                              &&
                     rs2_ID && rs2_ID == rd_EXE             &&
                     hazard_optype_EXE == hazard_optype_LOAD&&
                     hazard_optype_ID != hazard_optype_STORE ;  // will be solved by using forwarding, no stall
    wire stall = rs1_stall | rs2_stall;

    assign PC_EN_IF     = ~stall   ;
    assign reg_FD_EN    = ~stall   ;
    assign reg_FD_stall = stall    ;
    assign reg_FD_flush = Branch_ID;
    assign reg_DE_EN    = 1'b1     ;
    assign reg_DE_flush = stall    ;
    assign reg_EM_EN    = 1'b1     ;
    assign reg_EM_flush = 1'b0     ;
    assign reg_MW_EN    = 1'b1     ;

endmodule