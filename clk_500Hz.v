`timescale 1us / 100ps
/////////////////////////////////////////////////
// Company:  CSULB Student
// Engineer:  Derrik Bulmer
// 
// Create Date:    11:46:28 02/06/2013 
// Design Name: 
// Module Name:    clk_500Hz.v
// Project Name: 
//			CECS 301 Lab One
// Target Devices:
//       Spartan 3E 
// Tool versions: 
// Description: 
//				
// Dependencies: 
//				500 Hz has a period of 2 ms (2^9 ps)
//          
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/////////////////////////////////////////////////
module clk_500Hz(clk_in, rst, clock_500hz);
	input clk_in; // is the 50 MHz clock from board
	input rst;
   // clock divide to 500 Hz or .5 MHz
	// the clock on spartan 3e is 50 MHz
	// dividing by 20 will get .5 MHz
	// 50000000 Hz / 500 Hz = 100 000 / 2 = 50000
	output clock_500hz;
	wire clock_500hz;  // debounced clock
	reg [15:0] y; // counter 50000 = b 1100 0011 0101 0000
	
	// clock out gets high when these bits all "and" to one
	// the value of 50000 in binary
	assign clock_500hz = 
	y[15] && y[14] && y[9] && y[8] && y[6] && y[4]; 
	
	// required to set the counter to zero on start up every time 
	// it should start at zero, otherwise it will be high impedence
	initial begin
	y = 0;  
   end	
	
	always@(posedge clk_in, posedge rst)
	begin
		if(rst)
				y = 0; // rst counter
		else if(y >= 50000) y = 0;
		else  // count pos edge of input clk
				y = (y + 1'b1); // increament counter
	end
	
	
endmodule
