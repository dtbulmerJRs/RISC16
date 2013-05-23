`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSULB
// Engineer: Derrik Bulmer, Wilson Reimer
// 
// Create Date:    09:17:47 04/02/2013 
// Design Name: 
// Module Name:    toplevel6 
// Project Name:   lab six
// Target Devices: 
// Tool versions: 
// Description: 
//    Similar to the lab 5 datapath, however, it 
//    performs ALU arithmetic operations
//		on the data input and the "hard coded"
//		
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU_EU(clk,rst,we,s_sel,adr_sel,pc_sel,pc_ld,pc_inc,ir_ld, Din, Address, Dout, C, N, Z);
   input          clk; // on board 50 MHz clock
   input   rst, we,s_sel, adr_sel,pc_sel,pc_ld,pc_inc,ir_ld;
   input  [15:0] Din; wire [15:0] Din; 
	output [15:0] Dout; wire [15:0] Dout; // 
	output [15:0] Address; wire [15:0] Address;
	output  C, N, Z;
   	
   wire           clkTodb;
   wire           dbToIDM;
   wire   [15:0]  Reg_Out;
	wire [15:0] Alu_Out;
	wire [15:0] pc_mux_to_PC;
	wire [15:0] sixteen_bit_add;
	wire [15:0] SignExt;
	// the two 16 bits regs
	// PC
	reg [15:0] PC;
	// IR
	reg [15:0] IR;
	
	//initial PC = 16'b0;
	//initial IR = 16'b0;
	
	// behavioral logic
	always@(posedge clk, posedge rst)
	begin
		if(rst) begin
					PC = 16'b0;
					IR = 16'b0;
				  end
		else	  
		begin
					if(ir_ld) IR = Din;
					if(pc_inc) PC = PC + 1'b1;
					else if(pc_ld) PC = pc_mux_to_PC;
					else	  
					begin
						PC = PC;
						IR = IR;
					end
		end
			
	end			  
	
	
			
	assign Dout = Alu_Out;	

	
	// adr_mux
	assign Address = adr_sel ? Reg_Out : PC;
	
	//PC_mux

	//16 bit add
	assign sixteen_bit_add = PC + SignExt;
	
	assign SignExt = {{8{IR[7]}},IR[7:0]};
	
	assign pc_mux_to_PC = (pc_sel == 1'b1) ? Alu_Out : sixteen_bit_add; 
	
	
   //                               clk  ,  we , reset ,  W_adr   , 
   integer_datapath_module   IDM1(clk,     we,     rst,   IR[8:6],
   //                                   //R_adr       ,    S_adr ,
                                       IR[5:3]      ,    IR[2:0],
   //                                //DS   ,  sel  ,   ALU_OP   ,
                                    Din,     s_sel,    IR[15:12],
   //                           // C, N, Z Reg_Out, Alu_Out, 
                                   C, N, Z, Reg_Out, Alu_Out);
endmodule
