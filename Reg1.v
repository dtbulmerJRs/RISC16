`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:48 03/17/2013 
// Design Name: 
// Module Name:    Reg1 
// Project Name:  lab 6
// Target Devices: 
// Tool versions: 
// Description: 
//			same module for storing 16 bits
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Reg16(clk,reset,ld,din,DA,DB,eA,eB); // this module is better
	input clk, reset, ld, eA, eB;
	input [15:0] din;
	output [15:0] DA, DB;
	reg [15:0] r;
	
	always @(posedge clk, posedge reset)
	begin
		if(reset == 1'b1)
		begin
			r <= 16'h0;
		end
		else
		begin
			if(ld == 1'b1)
			begin
				r <= din;
			end
		end
	end
				
	assign DA = eA ? r : 16'hz; // high impediance means no change
	assign DB = eB ? r : 16'hz;

endmodule
