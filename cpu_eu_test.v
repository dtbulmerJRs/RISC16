`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:47:51 04/18/2013
// Design Name:   CPU_EU
// Module Name:   C:/lab7/cpu_eu_test.v
// Project Name:  lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU_EU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_eu_test;

	// Inputs
	reg clk;
	reg rst;
	reg we;
	reg s_sel;
	reg pc_ld;
	reg pc_inc;
	reg ir_ld;
	reg [15:0] Din;
	reg [31:0] i;
	// Outputs
	wire [15:0] Addr_Out;
	wire [15:0] Dout;

	// Instantiate the Unit Under Test (UUT)
	CPU_EU uut (
		.clk(clk), 
		.rst(rst), 
		.we(we), 
		.s_sel(s_sel), 
		.pc_ld(pc_ld), 
		.pc_inc(pc_inc), 
		.ir_ld(ir_ld), 
		.Din(Din), 
		.Addr_Out(Addr_Out), 
		.Dout(Dout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		we = 0;
		s_sel = 0;
		pc_ld = 0;
		pc_inc = 0;
		ir_ld = 0;
		Din = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		ir_ld = 1;
		//step = 1;
		#10
		
		ir_ld = 0;
		we = 1;
		pc_inc = 1;
		//step = 1;
		#10
		ir_ld = 1;
		//step = 1;
		#10
		ir_ld = 0;
		s_sel = 1;
		we = 1;
		pc_inc = 1;
		//step = 1;
		#10
		ir_ld = 1;
		//step = 1;
		#10
		s_sel = 1;
		we = 1;
		pc_inc = 1;
	end
      
endmodule

