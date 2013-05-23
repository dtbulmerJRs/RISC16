`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Derrik Bulmer, Wilson Reimer
// 
// Create Date:    15:42:55 03/29/2013 
// Design Name: 
// Module Name:    integer_datapath_module 
// Project Name:  lab 6
// Target Devices: 
// Tool versions: 
// Description:  Integer datapath module is the toplevel of
//						lab 5, which uses an 8 bit register,
//						one write datapath, 2 read data paths.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module integer_datapath_module(clk,we,reset,W_adr,R_adr,S_adr,DS,sel,
                               ALU_OP,C,N,Z, Reg_Out, Alu_Out);
	input            clk, we, reset, sel;
	input    [2:0]   W_adr,R_adr,S_adr;
	input    [15:0]  DS;
	input    [3:0]   ALU_OP;
   output wire          C,N,Z;
   output wire  [15:0]  Reg_Out;
	output wire  [15:0]  Alu_Out;
   wire         [15:0]  regToALU;
   wire         [15:0]  regToSMux;
   wire         [15:0]  SMuxToALU;
                
                
   //                   clk , reset , we , W_adr ,    W     , 
   reg_file     reg1   (clk , reset , we , W_adr , Alu_Out  , 
   //                   R_adr ,    R     , S_adr ,    S
                        R_adr , Reg_Out , S_adr , regToSMux);
                        
   //                       S     , DS , sel ,  MuxOut
   SMUX         smux1  (regToSMux , DS , sel , SMuxToALU);
   
   //                       R    ,     S     , Alu_Op ,    Y    ,
   alu          alu1   (Reg_Out , SMuxToALU , ALU_OP , Alu_Out ,
   //                   C , N , Z   
                        C , N , Z);
endmodule