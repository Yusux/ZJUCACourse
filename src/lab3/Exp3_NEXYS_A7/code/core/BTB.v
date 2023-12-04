`timescale 1ns / 1ps

module BTB
#(parameter TAG_BITS = 22) (
    input wire          clk,
    input wire          rst,
    input wire [31:0]   PC,

    input wire          update,
    input wire [31:0]   source_PC,
    input wire [31:0]   target_PC,

    output wire         is_predict_found,
    output wire [31:0]  predict_PC
);
    localparam TAG_SIZE = 1 << TAG_BITS;
    localparam INDEX_BITS = 32 - TAG_BITS;
    localparam INDEX_SIZE = 1 << INDEX_BITS;
    localparam BTBE_SIZE = 1 + TAG_BITS + 32;

    integer i;

    // set the regs to represent the BTB
    // {valid, tag, target_PC}, valid is 1 bit, tag is TAG_BITS bits, target_PC is 32 bits
    // which uses the direct mapping method like cache
    reg [BTBE_SIZE-1:0] BTB [0:INDEX_SIZE-1];

    // PREDICT PART
    // get the index of the PC
    wire [INDEX_BITS-1:0] index = PC[INDEX_BITS-1:0];       // 32 - TAG_BITS bits
    // get the tag of the PC
    wire [TAG_BITS-1:0] tag = PC[31:31-TAG_BITS+1];         // TAG_BITS bits

    // get the BTBE of the index got from the PC
    wire [BTBE_SIZE-1:0] BTBE = BTB[index];                 // BTBE_SIZE bits
    wire BTBE_valid = BTBE[BTBE_SIZE-1];                    // 1 bit
    wire [TAG_BITS-1:0] BTBE_tag = BTBE[BTBE_SIZE-2:32];    // TAG_BITS bits
    wire [31:0] BTBE_target_PC = BTBE[31:0];                // 32 bits

    // get the is_predict_found and predict_PC
    assign is_predict_found = BTBE_valid && (BTBE_tag == tag);
    assign predict_PC = BTBE_target_PC;

    // UPDATE PART
    // get the index of the PC
    wire [INDEX_BITS-1:0] update_index = source_PC[INDEX_BITS-1:0];       // 32 - TAG_BITS bits
    // get the tag of the PC
    wire [TAG_BITS-1:0] update_tag = source_PC[31:31-TAG_BITS+1];         // TAG_BITS bits

    // get the BTBE of the index got from the PC
    wire [BTBE_SIZE-1:0] update_BTBE = BTB[update_index];                 // BTBE_SIZE bits
    wire update_BTBE_valid = update_BTBE[BTBE_SIZE-1];                    // 1 bit
    wire [TAG_BITS-1:0] update_BTBE_tag = update_BTBE[BTBE_SIZE-2:32];    // TAG_BITS bits
    wire [31:0] update_BTBE_target_PC = update_BTBE[31:0];                // 32 bits

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // initialize the BHT
            for (i = 0; i < INDEX_SIZE; i = i + 1) begin
                BTB[i] <= 0;
            end
        end else begin
            if (update) begin
                BTB[update_index] <= {1'b1, update_tag, target_PC};
            end
        end
    end

endmodule