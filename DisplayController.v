`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     CSULB Student
// Engineer:    Derrik Bulmer
//              Wilson Reimer
// 
// Create Date:    19:54:02 03/15/2013 
// Design Name: 
// Module Name:    DisplayController 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//      Contains led clock, led controller, and address MUX.
//      Refer to the individual modules to explain what the
//      entire display controller description.
//
// Dependencies: 
//      Refer to the individual modules for dependencies
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DisplayController(clk_in, reset,R_hi,R_lo,S_hi,S_lo,anodes,a,b,c,d,e,f,g);
input          clk_in, reset;
//input   [7:0]  S;           //Represents the Address
//input   [7:0]  R;            //Represents the Data
   input     [3:0] S_hi;
   input     [3:0] S_lo;
   input     [3:0] R_hi;
input     [3:0] R_lo;
output wire [3:0]  anodes;
wire  [3:0]  ad_hex;  // changed to wire from lab4 
output wire a,b,c,d,e,f,g;
// WIRES
wire clkToCon;
wire [1:0] segSel;

// MODULES
         //              clk_in, reset, clock_250hz
led_clk           lclk  (clk_in, reset,  clkToCon);
         //                clk,    reset,  anode3  ,  anode2  ,  anode1  ,  anode0  , seg_sel
led_controller    ledcon(clkToCon, reset, anodes[3], anodes[2], anodes[1], anodes[0], segSel);
         //              seg_sel,  R_hi , R_lo  , S_hi  , S_lo  , ad_out
ad_mux            addr_mux(segSel, R_hi, R_lo, S_hi, S_lo, ad_hex);
         //                  in,       out
hex_to_7seg       hexSeven(ad_hex,{a,b,c,d,e,f,g});
endmodule
