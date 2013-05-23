`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:33:56 04/18/2013
// Design Name:   ram_256x16
// Module Name:   C:/lab7/ramtest.v
// Project Name:  lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram_256x16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ramtest;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [7:0] addra;
	reg [15:0] dina;
	reg [31:0] i;
	// Outputs
	wire [15:0] douta;

	// Instantiate the Unit Under Test (UUT)
	ram_256x16 uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);
   always #5 clka = ~clka;
	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		for(i = 0; i < 256; i = i + 1)
		begin
			@(negedge clka)
			begin
				addra = i;
				$display("addra = %h  douta = %h", addra, douta);
			end
		end
		$finish;
	end
      
endmodule

