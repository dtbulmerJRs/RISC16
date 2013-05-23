`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:04 04/12/2013 
// Design Name: 
// Module Name:    Ram16 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Ram16(addra,wea,dina,clka,douta);
	input [7:0] addra;
	input wea;
	input [15:0] dina;
	input clka;
	output [15:0] douta;
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
ram_256x16 Ram16(
  .clka(clka), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [7 : 0] addra
  .dina(dina), // input [15 : 0] dina
  .douta(douta) // output [15 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------



endmodule
