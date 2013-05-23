`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:46 05/05/2013 
// Design Name: 
// Module Name:    top_lab8 
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
module top_lab8(clk,rst,step_mem,step_clk,ad_sel,dump_mem,anodes,a,b,c,d,e,f,g,N,Z,C);
input clk,rst,step_mem,step_clk,ad_sel,dump_mem;
output a,b,c,d,e,f,g;
output [3:0] anodes;
wire stepToCU; // clks
output wire N,Z,C;
wire [2:0] Wadr, Radr, Sadr;
wire rw_en,pc_sel,pc_ld,pc_inc,adr_sel,s_sel,ir_ld;
wire [15:0] IR,Address,Dout,Mem_Out;
wire [3:0] alu_op;
wire [7:0] status;
wire [15:0] dc_in;

assign dc_in = (adr_sel == 1'b1) ? Address : Mem_Out;


reg [15:0] mem_counter;


always@(posedge rst, posedge step_mem)
begin
	if(rst)mem_counter = 0;
	if(step_mem)mem_counter = mem_counter + 1'b1;
end

assign Address = dump_mem ? mem_counter : Address;


//             clk, reset , clk_out
clk_500Hz clk1(clk,  rst  , clkTodb);
Ram16	ram(Address[7:0],mw_en,Dout,clk,Mem_Out);
debounce stepper(clk, rst, step_clk,stepToCU);
/*
		clk,rst,IR,N,Z,C,Waddr,Raddr,
			Saddr,adr_sel, s_sel, pc_ld,
			pc_inc, pc_sel, ir_ld, mw_en,
			rw_en, alu_op, status
*/
CU controlunit(stepToCU,rst,IR,N,Z,C,Wadr,Radr,Sadr, 
		adr_sel, s_sel, pc_sel, pc_ld, pc_inc, pc_sel, 
		ir_ld, mw_en, rw_en, alu_op,status);
/*
CPU_EU(clk,rst,we,s_sel,adr_sel,pc_ld,pc_inc,ir_ld, Din, Address, Dout, C, N, Z
*/
CPU_EU cpu_EU(stepToCU,rst,rw_en,s_sel,adr_sel,pc_ld,pc_inc,ir_ld,Mem_Out, Address, Dout, C, N, Z);

//DisplayController(clk_in, reset,R_hi,R_lo,S_hi,S_lo,anodes,a,b,c,d,e,f,g)
DisplayController dc(clk, rst,dc_in[15:12],dc_in[11:8],dc_in[7:4],dc_in[3:0],anodes,a,b,c,d,e,f,g);

endmodule
