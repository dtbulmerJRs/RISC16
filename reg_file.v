`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Derrik Bulmer, Wilson Reimer
// 
// Create Date:    14:10:53 03/17/2013 
// Design Name: 
// Module Name:    reg_file 
// Project Name:  lab 6
// Target Devices: 
// Tool versions: 
// Description: 
//					contains a 8 16 bit registers
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reg_file(clk,reset,we,W_adr,W,R_adr,R,S_adr,S);
		input clk, reset, we;
		input [2:0] W_adr, R_adr, S_adr;
		input [15:0] W;// data to be written
		output [15:0] R; // data to be read path 1
	   output [15:0] S; // data to be read path 2
		wire [15:0] DA,DB;
		wire ld7,ld6,ld5,ld4,ld3,ld2,ld1,ld0;
		wire ea7,ea6,ea5,ea4,ea3,ea2,ea1,ea0;
		wire eb7,eb6,eb5,eb4,eb3,eb2,eb1,eb0;
				
				 // clk,reset,ld,W,DA,DB,ea,eb
		Reg16 r0(clk,reset,ld0,W,DA,DB,ea0,eb0);
		Reg16 r1(clk,reset,ld1,W,DA,DB,ea1,eb1);
		Reg16 r2(clk,reset,ld2,W,DA,DB,ea2,eb2);
		Reg16 r3(clk,reset,ld3,W,DA,DB,ea3,eb3);
		Reg16 r4(clk,reset,ld4,W,DA,DB,ea4,eb4);
		Reg16 r5(clk,reset,ld5,W,DA,DB,ea5,eb5);
		Reg16 r6(clk,reset,ld6,W,DA,DB,ea6,eb6);
		Reg16 r7(clk,reset,ld7,W,DA,DB,ea7,eb7);
			  
		assign R = DA;
		assign S = DB;
		
		///                data,  en,    output
		decoder3to8 W_dec(W_adr, we, ld7,ld6,ld5,ld4,ld3,ld2,ld1,ld0);
								// R_adr,  always enabled, wires
		decoder3to8 R_dec(R_adr, 1'b1, ea7,ea6,ea5,ea4,ea3,ea2,ea1,ea0);
		decoder3to8 S_dec(S_adr, 1'b1, eb7,eb6,eb5,eb4,eb3,eb2,eb1,eb0);

endmodule
