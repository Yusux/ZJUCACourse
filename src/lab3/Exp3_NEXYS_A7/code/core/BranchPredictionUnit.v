`timescale 1ns / 1ps

module BranchPredictionUnit
#(parameter TAG_BITS = 10) (
    input wire          clk,
    input wire          rst,
    input wire [31:0]   PC,
    input wire [31:0]   inst,

    input wire          update,
    input wire [31:0]   source_PC,
    input wire          is_taken,
    input wire [31:0]   target_PC,

    output wire         is_predict_taken,
    output wire [31:0]  predict_PC
);
    // wires for BHT
    wire        is_predict_found_BHT;
    wire        is_predict_taken_BHT;
    // wires for BTB
    wire        is_predict_found_BTB;
    wire [31:0] predict_PC_BTB;
    // wires for inst decode
    wire [6:0]  funct7 = inst[31:25];
    wire [2:0]  funct3 = inst[14:12];
    wire [6:0]  opcode = inst[6:0];
    wire        funct3_0 = funct3 == 3'h0;
    wire        funct3_1 = funct3 == 3'h1;
    wire        funct3_4 = funct3 == 3'h4;
    wire        funct3_5 = funct3 == 3'h5;
    wire        funct3_6 = funct3 == 3'h6;
    wire        funct3_7 = funct3 == 3'h7;
    wire        Bop = opcode == 7'b1100011;
    wire        BEQ = Bop & funct3_0;
    wire        BNE = Bop & funct3_1;
    wire        BLT = Bop & funct3_4;
    wire        BGE = Bop & funct3_5;
    wire        BLTU = Bop & funct3_6;
    wire        BGEU = Bop & funct3_7;
    wire        B_valid = BEQ | BNE | BLT | BGE | BLTU | BGEU;
    wire        JAL  =  opcode == 7'b1101111;
    wire        JALR = (opcode == 7'b1100111) && funct3_0;
    wire        is_branch_or_jump = B_valid | JAL | JALR;

    // Connect the BHT
    BHT #(.TAG_BITS(TAG_BITS)) BHT_inst (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .update(update),
        .source_PC(source_PC),
        .is_taken(is_taken),
        .is_predict_found(is_predict_found_BHT),
        .is_predict_taken(is_predict_taken_BHT)
    );

    // Connect the BTB
    BTB #(.TAG_BITS(TAG_BITS)) BTB_inst (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .update(update && is_taken),
        .source_PC(source_PC),
        .target_PC(target_PC),
        .is_predict_found(is_predict_found_BTB),
        .predict_PC(predict_PC_BTB)
    );

    // get the is_predict_taken and predict_PC
    assign is_predict_taken = is_branch_or_jump && is_predict_found_BHT && is_predict_found_BTB && is_predict_taken_BHT;
    assign predict_PC = predict_PC_BTB;

endmodule