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
    
    
    reg [159:0] rs[`MAXLEN:0];  // not use 0? depends on u
     

endmodule
