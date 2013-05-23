`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        CSULB Student
// Engineer:       Derrik Bulmer
//                 Wilson Reimer
// 
// Create Date:    17:23:55 02/22/2013 
// Design Name:    hex_to_7seg_converter.v
// Module Name:    hex_to_7seg_converter 
// Project Name:   Lab Three CECS 301 (lab3_cecs301.xise)
// Target Devices: Spartan3E
// Tool versions: 
// Description: 
//		 a three bit binary is converted to a hex value.
//		 stucturally it is quite similar to a mux or a decoder/encoder.
//		 In this lab, the module is really an octal to 7 segment converter,
//		 so in future labs it will be modified for a real hex value
// Dependencies: 
//		 only needs a top module to instantiate it.  
//  	 Do not probe outputs in this module, only use the "Out" output
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module hex_to_7seg(In, Out);
// 3 binary bits form an octal, input is 'o
// 4 binary bits form a hex, input is converted from octal to hex
input [3:0] In;

// 7 binary bits form a 7 segment display value
/*
Note:  the seven segment display only requires
7 total bits for the decimal 0-9 digital representations
however other shapes can be used, such as error messages
*/
output reg [6:0] Out;

/* switch cases using octals
 
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 Note for changing values in future labs
 n bits in input equals 2^n cases
 dont forget to change the 'b 'o 'h 
 accordingly to suite each lab requirements
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/ 
always@(In)
begin
	case(In)
		/*
		TOOL FORMAT:      abcdefg
		    a
		    _
		 f | | b
		    -g
		 e	|_| c
		    d
		*/
		// case 000       abcdefg
		4'b0000:	Out = 7'b1111110;
		// case 001
		4'b0001:  Out = 7'b0110000;
		// case 010
		4'b0010:  Out = 7'b1101101;
		// case 011
		4'b0011:  Out = 7'b1111001;
		// case 100
		4'b0100:  Out = 7'b0110011;
		// case 101
		4'b0101:  Out = 7'b1011011;
		// case 110
		4'b0110:  Out = 7'b1011111;
		// case 111
		4'b0111:  Out = 7'b1110000;
		// case 1000       abcdefg
		4'b1000:	Out = 7'b1111111;
		// case 1001
		4'b1001:  Out = 7'b1110011;
		// case 1010
		4'b1010:  Out = 7'b1110111;
		// case 1011
		4'b1011:  Out = 7'b0011111;
		// case 1100
		4'b1100:  Out = 7'b1001110;
		// case 1101
		4'b1101:  Out = 7'b0111101;
		// case 1110
		4'b1110:  Out = 7'b1001111;
		// case 1111
		4'b1111:  Out = 7'b1000111;
		/*
		Here is where new cases would be added
		*/
		/* Note for future labs
		this segment below is correct 7 seg display
		cut and paste below before the default if 
		cases for 8 and 9 are not there
		// case 1000
		4'b1000:  Out = 7'b1111111;
		// case 1001
		4'b1001:  Out = 7'b1111011;
		*/
		
		// future labs, add cases here...
		
		
		// default error state is a '-' type display
		default:	 Out = 7'b0000001;
	endcase	
	
	// the display is Not gated, so invert the bits
	Out = ~Out;
end	
endmodule
