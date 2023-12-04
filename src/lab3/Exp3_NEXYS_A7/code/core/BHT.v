`timescale 1ns / 1ps

module BHT
#(parameter TAG_BITS = 10) (
    input wire          clk,
    input wire          rst,
    input wire [31:0]   PC,

    input wire          update,
    input wire [31:0]   source_PC,
    input wire          is_taken,

    output wire         is_predict_found,
    output wire         is_predict_taken
);
    localparam TAG_SIZE = 1 << TAG_BITS;
    localparam INDEX_BITS = 32 - TAG_BITS;
    localparam BHTE_SIZE = 1 + TAG_BITS + 2;

    integer i;

    // set the regs to represent the BHT
    // {valid, tag, is_taken}, valid is 1 bit, tag is TAG_BITS bits, is_taken is 2 bits
    // which uses the direct mapping method like cache
    reg [BHTE_SIZE-1:0] BHT [0:TAG_SIZE-1];

    // PREDICT PART
    // get the index of the PC
    wire [INDEX_BITS-1:0] index = PC[INDEX_BITS-1:0];       // 32 - TAG_BITS bits
    // get the tag of the PC
    wire [TAG_BITS-1:0] tag = PC[31:31-TAG_BITS+1];         // TAG_BITS bits

    // get the BHTE of the index got from the PC
    wire [BHTE_SIZE-1:0] BHTE = BHT[index];                 // BHTE_SIZE bits
    wire BHTE_valid = BHTE[0];                              // 1 bit
    wire [TAG_BITS-1:0] BHTE_tag = BHTE[1+TAG_BITS-1:1];    // TAG_BITS bits
    wire [1:0] BHTE_is_taken = BHTE[BHTE_SIZE-1:2];         // 2 bits

    // get the is_predict_found and is_predict_taken
    assign is_predict_found = BHTE_valid && (BHTE_tag == tag);
    assign is_predict_taken = BHTE_valid && (BHTE_tag == tag) && (BHTE_is_taken[1] == 1'b1);

    // UPDATE PART
    // get the index of the PC
    wire [INDEX_BITS-1:0] update_index = source_PC[INDEX_BITS-1:0];       // 32 - TAG_BITS bits
    // get the tag of the PC
    wire [TAG_BITS-1:0] update_tag = source_PC[31:31-TAG_BITS+1];         // TAG_BITS bits

    // get the BHTE of the index got from the PC
    wire [BHTE_SIZE-1:0] update_BHTE = BHT[update_index];                 // BHTE_SIZE bits
    wire update_BHTE_valid = update_BHTE[0];                              // 1 bit
    wire [TAG_BITS-1:0] update_BHTE_tag = update_BHTE[1+TAG_BITS-1:1];    // TAG_BITS bits
    wire [1:0] update_BHTE_is_taken = update_BHTE[BHTE_SIZE-1:2];         // 2 bits

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // initialize the BHT
            for (i = 0; i < TAG_SIZE; i = i + 1) begin
                BHT[i] <= 0;
            end
        end else begin
            if (update) begin
                if (update_BHTE_valid && (update_BHTE_tag == update_tag)) begin
                    if (is_taken) begin
                        case (update_BHTE_is_taken)
                            2'b00: BHT[update_index] <= {1'b1, update_tag, 2'b01};
                            2'b01: BHT[update_index] <= {1'b1, update_tag, 2'b11};
                            2'b10: BHT[update_index] <= {1'b1, update_tag, 2'b11};
                            2'b11: BHT[update_index] <= {1'b1, update_tag, 2'b11};
                        endcase
                    end else begin
                        case (update_BHTE_is_taken)
                            2'b00: BHT[update_index] <= {1'b1, update_tag, 2'b00};
                            2'b01: BHT[update_index] <= {1'b1, update_tag, 2'b00};
                            2'b10: BHT[update_index] <= {1'b1, update_tag, 2'b00};
                            2'b11: BHT[update_index] <= {1'b1, update_tag, 2'b10};
                        endcase
                    end
                end else begin
                    if (is_taken) begin
                        BHT[update_index] <= {1'b1, update_tag, 2'b10};
                    end else begin
                        BHT[update_index] <= {1'b1, update_tag, 2'b01};
                    end
                end
            end
        end
    end

endmodule