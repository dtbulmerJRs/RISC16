`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        CSULB Student
// Engineer:
//                 Wilson Reimer
//                 Derrik Bulmer
// 
// Create Date:    12:49:32 03/30/2013 
// Design Name: 
// Module Name:    SMUX 
// Project Name:   Lab_6
// Target Devices: 
// Tool versions: 
// Description: 
//                 The input S or the input DS will be 
//                 returned as the output MuxOut based
//                 on the select value sel. 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SMUX(S,DS,sel,MuxOut);
   input  [15:0] S;
   input  [15:0] DS;
   input         sel;
   output [15:0] MuxOut; wire [15:0] MuxOut;
   
   assign MuxOut = sel ? DS:S;   //DS = 1, S = 0


endmodule
