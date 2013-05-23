`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////
// Company: CSULB Student
// Engineer: Derrik Bulmer
// 
// Create Date:    11:44:43 02/06/2013 
// Design Name: 
// Module Name:    debounce.v
// Project Name:    
//        CECS 301 Lab One
// Target Devices: 
//				Spartan 3E
// Tool versions: 
// Description: 
//          sends a oneshot pulse on input <BTN0> (see ucf)
//				to the shift register modules' clock input.
// 			the debouncer stablizes for 8 clock cycles
//				but outputs only on the seventh input capture
//				The clock in this lab is 500 Hz with a period
//				of 2 ms.  The debouncer here stablizes for 
//				8cycles X 2ms = 16 ms of capture, which
//				makes up for the approx. 10-15 ms stablization
//				period of the push button.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////
module debounce(clk, reset, Din, Dout);
	// incoming clock, most likely the "raw" clock
	input clk; 
	// the reset, usually shared by all modules in
	input	reset; 
	// the 
	input Din;
	output Dout; wire Dout;
	
	// this functions as a sequential logic shift register
	reg q7, q6, q5, q4, q3, q2, q1, q0;
	// every clock cycle is a shift.  8 clock ticks for one pulse
	always @(posedge clk or posedge reset)
		if(reset == 1'b1)
			{q7, q6, q5, q4, q3, q2, q1, q0} = 8'b0;
		else begin
		q7 = q6;
		q6 = q5;
		q5 = q4;
		q4 = q3;
		q3 = q2;
		q2 = q1;
		q1 = q0;
		q0 = Din;
		
		end
		//  pulse occures when the reg =  0111 1111
		// or 7 clock cycles
	assign Dout = !q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;

endmodule
