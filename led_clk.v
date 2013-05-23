`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:    CSULB Student
// Engineer:   Wilson Reimer
//             Derrik Bulmer
// 
// Create Date:    14:55:50 03/10/2013 
// Design Name: 
// Module Name:    led_clk 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//       Used to multiplux a common anode input
//       to the 7-segment display
//
// Dependencies: 
//       The reduced clock (clk_500Hz) and reset 
//       provided by button 3.
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module led_clk(clk_in,rst,clock_250hz);
   input    clk_in,rst;
   output   clock_250hz;
   
   reg      clock_250hz;  // debounced clock
   integer  counter;  // counter 25000 = 16'b110000110101000
	
	
   // required to set the counter to zero on start up every time 
   // it should start at zero, otherwise it will be high impedence
   initial begin
   counter = 0;  
   end	
	
   always@(posedge clk_in, posedge rst)
     if(rst == 1'b1)
       begin
            counter = 0; // rst counter
            clock_250hz = 0;
       end
     else
       begin
            counter = (counter + 1); // increment counter
            if(counter >= 25000)
              begin
                   clock_250hz = ~clock_250hz;
                   counter = 0;
              end
            
	  end
endmodule
