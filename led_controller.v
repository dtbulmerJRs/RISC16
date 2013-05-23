`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   CSULB Student
// Engineer:  Wilson Reimer
//            Derrik Bulmer
// 
// Create Date:    09:56:16 03/10/2013 
// Design Name: 
// Module Name:    led_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//      Generates the signal for the
//      7-segment display and select signals
//      for the address/data nibbles
//
// Dependencies: 
//      LED Clock's output and reset from button 3
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module led_controller(clk,reset,a3,a2,a1,a0,seg_sel);
   input          clk, reset;
   output         a3,a2,a1,a0;    //Represents the anodes
   reg            a3,a2,a1,a0;
   output  [1:0]  seg_sel;
   reg     [1:0]  seg_sel;
	               
   reg     [1:0]  ps;
   reg     [1:0]  ns;
	
   // next state combo
   always @(ps) 
     begin
       case(ps)
         2'b00:   ns = 2'b01;
         2'b01:   ns = 2'b10;
         2'b10:   ns = 2'b11;
         2'b11:   ns = 2'b00;
         default: ns = 2'b00;
     endcase
   end
	
   // state reg
   always@(posedge clk, posedge reset)
   begin
      if(reset == 1'b1)  ps = 2'b00;
      else               ps = ns;
   end

	// output combo logic
   always@(ps)
   begin
      case(ps)
         2'b00:   {seg_sel,a3,a2,a1,a0} = 6'b001110; // 00 in admux is S_lo
         2'b01:   {seg_sel,a3,a2,a1,a0} = 6'b011101; // 01 in admux is S_hi
         2'b10:   {seg_sel,a3,a2,a1,a0} = 6'b101011; // 10 in admux is R_lo
         2'b11:   {seg_sel,a3,a2,a1,a0} = 6'b110111; // 11 in admux is R_hi
         default: {seg_sel,a3,a2,a1,a0} = 6'b001110; 
      endcase
   end

endmodule
