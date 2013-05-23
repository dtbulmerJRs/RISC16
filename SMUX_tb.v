`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:04:01 03/30/2013
// Design Name:   SMUX
// Module Name:   C:/Users/Wilson/Dropbox/lab6allversions/Saturday/SMUX_tb.v
// Project Name:  lab6derrikwilson
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SMUX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SMUX_tb;

	// Inputs
	reg [15:0] S;
	reg [15:0] DS;
	reg sel;

	// Outputs
	wire [15:0] MuxOut;

	// Instantiate the Unit Under Test (UUT)
	SMUX uut (
		.S(S), 
		.DS(DS), 
		.sel(sel), 
		.MuxOut(MuxOut)
	);


	initial begin
		// Initialize Inputs
		S = 0;
		DS = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
      begin
        sel = 0; 
        DS = 2'b10;
        S =  2'b01;
        end
		// Add stimulus here

	end
      
endmodule

