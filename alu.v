`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:12 03/29/2013 
// Design Name: 
// Module Name:    alu 
// Project Name:  lab 6
// Target Devices: 
// Tool versions: 
// Description: 
//			an arithmetic logic unit that performs operations
//			operations on the contents on the register
//       based off of a 4 bit input code	
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(R,S,Alu_Op,Y,C,N,Z);
	input      [15:0] R,S; // register data
	input   wire   [3:0]  Alu_Op; // selection
	output     [15:0] Y;  reg [15:0] Y; // result buff
	output       C,N,Z;   reg  C,N,Z; // carry, negative, zero flags
	
	always @(R or S or Alu_Op)
	begin
	case(Alu_Op)
		4'b0000: {C,Y} = {1'b0,   S}; // load s
		4'b0001: {C,Y} = {1'b0,   R}; // load r
		4'b0010: {C,Y} =  R + S;  // add
		4'b0011: {C,Y} =  R - S;  // sub
		4'b0100: {C,Y} =  S + 1;  // inc
		4'b0101: {C,Y} =  S - 1;  // dec
		4'b0110: {C,Y} = {S[15],  S>>1}; // rr
		4'b0111: {C,Y} = {S[0],   S<<1}; // rl
		4'b1000: {C,Y} = {1'b0,   R & S}; // and
		4'b1001: {C,Y} = {1'b0,   R | S}; // or
		4'b1010: {C,Y} = {1'b0,   R ^ S}; // xor
		4'b1011: {C,Y} = {1'b0,  ~S}; // not
		4'b1100: {C,Y} = {1'b0,  -S}; // negative
			default: {C,Y} = {1'b0,   S}; // no change
	/*
		4'b0000: {C,Y} =  R + S;  // add
		4'b0001: {C,Y} =  R - S;
		4'b0010: begin
					if(R - S == 0) Z = 0
					else  Z = 1;
					end
		4'b0011: {C,Y} =  {1'b0,   R};  // sub
		4'b0100: {C,Y} =  {S[0],   S<<1};  
		4'b0101: {C,Y} =  {S[15],  S>>1};  // dec
		4'b0110: {C,Y} =  S + 1;  // inc
		4'b0111: {C,Y} = S - 1;  // dec
		4'b1000: {C,Y} = {1'b0,  S};
		4'b1001: {C,Y} = {1'b0,   R | S}; // or
		4'b1010: {C,Y} = {1'b0,   R ^ S}; // xor
		4'b1011: {C,Y} = {1'b0,  ~S}; // not
		default: {C,Y} = {1'b0,   S}; // no change
		*/
	endcase
	
	N = Y[15];
	if(Y == 16'b0)
		Z = 1'b1;
	else
		Z = 1'b0;
	
end

endmodule
