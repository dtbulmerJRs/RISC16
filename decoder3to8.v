`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Derrik Bulmer, Wilson Reimer
// 
// Create Date:    13:17:49 03/17/2013 
// Design Name: 
// Module Name:    decoder3to8 
// Project Name:  lab 6
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder3to8(din, en, y7, y6, y5, y4, y3, y2, y1, y0);
	input [2:0] din;
	input en;
	output reg y7, y6, y5, y4, y3, y2, y1, y0;
	
	always@(en) // theres your problem
	begin
		if(en == 1'b1)
		begin
		case(din)
			3'b000:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00000001;
			3'b001:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00000010;
			3'b010:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00000100;
			3'b011:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00001000;
			3'b100:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00010000;
			3'b101:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b00100000;
			3'b110:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b01000000;
			3'b111:  {y7,y6,y5,y4,y3,y2,y1,y0} = 8'b10000000;
			default: {y7,y6,y5,y4,y3,y2,y1,y0} = 8'bz;
		endcase
		end
	end

endmodule
