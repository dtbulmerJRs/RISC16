`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:    CSULB Student
// Engineer:   Derrik Bulmer
//             Wilson Reimer
// 
// Create Date:    11:09:09 03/10/2013 
// Design Name: 
// Module Name:    ad_mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:
//       A 4-to-1 MUX for the address/data
//       information to be multiplexed into
//       the 7-segment display.
//
// Dependencies: 
//       Segment select, incoming addresses,
//       and incoming data.
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ad_mux(seg_sel,R_hi,R_lo,S_hi,S_lo,ad_out);
   input     [1:0] seg_sel;
   input     [3:0] S_hi;
   input     [3:0] S_lo;
   input     [3:0] R_hi;
   input     [3:0] R_lo;
   output    [3:0] ad_out;
   reg       [3:0] ad_out;
	
   always @(seg_sel)
   case(seg_sel)
      2'b00:    ad_out = S_lo;
      2'b01:    ad_out = S_hi;
      2'b10:    ad_out = R_lo;
      2'b11:    ad_out = R_hi;
      default:  ad_out = 4'bz;  //if segment select is 0
                                //set to high impedance
	endcase

endmodule
