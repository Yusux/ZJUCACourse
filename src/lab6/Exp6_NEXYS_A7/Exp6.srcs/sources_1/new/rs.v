`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 20:29:49
// Design Name: 
// Module Name: rs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`include "CtrlDefine.vh" // RS entry bits is defined here

module RS

    // parameter 
    //  FU denotes type of this RS 
    //  num denotes how many entries this RS holds
    #(  parameter FU = `FU_BLANK, parameter num = 3 )
    (
            input clk,
			input rst,

            // IS			
			input selected, // dispatch an instr to this RS,
			output [7:0] free_rs, // 0 means no available entry; 
			                      // 7:5 ==> indicate which FU this RS manage; 4:0 ==> inner RS index
			input [4:0]op,
			input [7:0]Qj,
			input [7:0]Qk,
			input [31:0]Vj,
			input [31:0]Vk,
			input [31:0]A,
			input [31:0]pc_IS,
		
			// for FU EXE
			output en_FU,
			output [31:0]vj,
			output [31:0]vk,
			output [4:0]op_out,
			output [31:0] A_o,
			output [31:0] pc_FU, // for Jump FU

            output [7:0]cdb_rs_rd,   // indicate which entry's instr get executed in corresponding FU, for cdb broadcast 
            
			input [7:0] cdb_rs_num,  // cdb broadcast
			input [31:0]cdb_data,
			
           
            // for debug
            output [31:0] pc_debug
    );
    
	integer i;

	localparam NUM_BITS = $clog2(num);

    reg [159:0] rs[1:num]; // 160 bits per entry, totally num entries
	// use NUM_BITS bits (one more bit than num) to avoid
	// in case `1 2 3`, 3 first out and 2 second out, then 1 -> 3
	reg [NUM_BITS:0] rs_order[1:num]; // order of each entry
	reg [NUM_BITS:0] entries; // how many entries in this RS
	reg [4:0] free_index_reg; // 0 means no available entry; 
						   	  // 7:5 ==> indicate which FU this RS manage; 4:0 ==> inner RS index
	reg [4:0] ready_index; // 0 means no ready entry; 
						   // 4:0 ==> inner RS index

	assign free_rs = free_index_reg == 0 ? 0 : {FU, free_index_reg};
	assign en_FU = ready_index == 0 ? 0 : 1;
	assign vj = ready_index == 0 ? 0 : rs[ready_index][`V1_H:`V1_L];
	assign vk = ready_index == 0 ? 0 : rs[ready_index][`V2_H:`V2_L];
	assign op_out = ready_index == 0 ? 0 : rs[ready_index][`OP_H:`OP_L];
	assign A_o = ready_index == 0 ? 0 : rs[ready_index][`A_H:`A_L];	
	assign pc_FU = ready_index == 0 ? 0 : rs[ready_index][`PC_H:`PC_L];
	assign cdb_rs_rd = ready_index == 0 ? 0 : {FU, ready_index};
	assign pc_debug = ready_index == 0 ? 0 : rs[ready_index][`PC_H:`PC_L];

	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			for (i = 1; i <= num; i = i + 1) begin
				rs[i] <= 0;
				rs_order[i] <= 0;
			end
			entries <= 0;
			free_index_reg <= 1;
			ready_index <= 0;
		end
		else begin
			// update the rs according to cdb
			if (cdb_rs_num != 0) begin
				for (i = 1; i <= num; i = i + 1) begin
					// if cdb_rs_num equals to Qj, replace the old value
					if (rs[i][`BUSY] == 1 && rs[i][`Q1_H:`Q1_L] == cdb_rs_num) begin
						rs[i][`Q1_H:`Q1_L] = 0;
						rs[i][`V1_H:`V1_L] = cdb_data;
					end
					// if cdb_rs_num equals to Qk, replace the old value
					if (rs[i][`BUSY] == 1 && rs[i][`Q2_H:`Q2_L] == cdb_rs_num) begin
						rs[i][`Q2_H:`Q2_L] = 0;
						rs[i][`V2_H:`V2_L] = cdb_data;
					end
				end
				// if cdb_rs_num equals to rs_num, clear the entry
				if (cdb_rs_num[7:5] == FU) begin
					rs[cdb_rs_num[4:0]][`BUSY] = 0;
					rs[cdb_rs_num[4:0]] = 0;
					rs_order[cdb_rs_num[4:0]] = 0;
					entries = entries - 1;
					ready_index = 0;
					// decrement the rs_order
					for (i = 1; i <= num; i = i + 1) begin
						if (i != cdb_rs_num[4:0] && rs[i][`BUSY] == 1) begin
							rs_order[i] = rs_order[i] - 1;
						end
					end
				end
			end

			// if selected is 1, dispatch an instr to RS
			if (selected && free_index_reg != 0) begin
				// if selected, find a free RS entry
				rs[free_index_reg][`BUSY] = 1;
				rs[free_index_reg][`OP_H:`OP_L] <= op;

				// if cdb_rs_num equals to Qj, not to write the old value
				if (cdb_rs_num != 0 && Qj == cdb_rs_num) begin
					rs[free_index_reg][`Q1_H:`Q1_L] <= 0;
					rs[free_index_reg][`V1_H:`V1_L] <= cdb_data;
				end
				else begin
					if (Qj == 0) begin
						rs[free_index_reg][`Q1_H:`Q1_L] <= 0;
						rs[free_index_reg][`V1_H:`V1_L] <= Vj;
					end else begin
						rs[free_index_reg][`Q1_H:`Q1_L] <= Qj;
						rs[free_index_reg][`V1_H:`V1_L] <= 0;
					end
				end

				// if cdb_rs_num equals to Qk, not to write the old value
				if (cdb_rs_num != 0 && Qk == cdb_rs_num) begin
					rs[free_index_reg][`Q2_H:`Q2_L] <= 0;
					rs[free_index_reg][`V2_H:`V2_L] <= cdb_data;
				end
				else begin
					if (Qk == 0) begin
						rs[free_index_reg][`Q2_H:`Q2_L] <= 0;
						rs[free_index_reg][`V2_H:`V2_L] <= Vk;
					end else begin
						rs[free_index_reg][`Q2_H:`Q2_L] <= Qk;
						rs[free_index_reg][`V2_H:`V2_L] <= 0;
					end
				end

				rs[free_index_reg][`A_H:`A_L] <= A;
				rs[free_index_reg][`PC_H:`PC_L] <= pc_IS;

				// set the rs_order
				entries = entries + 1;
				rs_order[free_index_reg] = entries;
			end

			// if ready_index is 0, find a ready RS entry
			if (ready_index == 0) begin
				for (i = 1; i <= num; i = i + 1) begin : find_ready
					if (i != free_index_reg) begin
						if (rs[i][`BUSY] == 1 && rs[i][`Q1_H:`Q1_L] == 0 && rs[i][`Q2_H:`Q2_L] == 0) begin
							// compare as signed number
							if (ready_index == 0 || $signed(rs_order[i]) < $signed(rs_order[ready_index])) begin
								ready_index = i;
							end
							disable find_ready;
						end
					end
					else if (i == free_index_reg) begin
						if (rs[i][`BUSY] == 1 && Qj == 0 && Qk == 0) begin
							// compare as signed number
							if (ready_index == 0 || $signed(rs_order[i]) < $signed(rs_order[ready_index])) begin
								ready_index = i;
							end
							disable find_ready;
						end
					end
				end
			end

			// find next free RS entry
			free_index_reg <= 0;
			for (i = 1; i <= num; i = i + 1) begin
				if (rs[i][`BUSY] == 0) begin
					free_index_reg <= i;
				end
			end
		end
	end

endmodule
