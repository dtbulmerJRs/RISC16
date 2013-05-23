`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:51 03/17/2013 
// Design Name: 
// Module Name:    decoder3to8_tb 
// Project Name: 
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
module decoder3to8_tb(); // works
	reg [2:0] din;
	reg en;
	wire y7,y6,y5,y4,y3,y2,y1,y0;
	
	decoder3to8 dut(din,en,y7,y6,y5,y4,y3,y2,y1,y0);
	
	// just a truth table for {en,din[2], din[1], din[0]}
	initial begin
		en = 0;
		#10;
		din = 3'b000;
		#10;
		din = 3'b001;
		#10;
		din = 3'b010;
		#10;
		din = 3'b011;
		#10;
		din = 3'b100;
		#10;
		din = 3'b101;
		#10;
		din = 3'b110;
		#10;
		din = 3'b111;
		#10;
		
		en = 1;
		#10;
		din = 3'b000;
		#10;
		din = 3'b001;
		#10;
		din = 3'b010;
		#10;
		din = 3'b011;
		#10;
		din = 3'b100;
		#10;
		din = 3'b101;
		#10;
		din = 3'b110;
		#10;
		din = 3'b111;
		#10;		
	end
	
endmodule
