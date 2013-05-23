`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:38 05/05/2013 
// Design Name: 
// Module Name:    CU 
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
module CU(clk,reset,IR,N,Z,C,W_Adr,R_Adr,
			S_Adr,adr_sel, s_sel, pc_sel, pc_ld,
			pc_inc, pc_sel, ir_ld, mw_en,
			rw_en, alu_op, status);

input				clk, reset, N, Z, C;
input   [15:0] IR;
output  [2:0]  W_Adr,R_Adr,S_Adr;
output			adr_sel, s_sel, pc_ld,
					pc_inc, pc_sel, ir_ld,
					mw_en, rw_en;
output  [3:0]  alu_op;
output  [7:0]  status;

// control word
reg [2:0] W_Adr,R_Adr,S_Adr;
reg 	adr_sel,s_sel, pc_ld, pc_inc, pc_sel,
		ir_ld, mw_en, rw_en;
reg  [3:0] alu_op;

// state regs
reg	[4:0] state, nextstate;
reg   [7:0] status;
reg   ps_N, ps_Z, ps_C;
reg   ns_N, ns_Z, ns_C;

parameter
RESET=0, 
FETCH=1,
ADD=3,
SUB=4,
INC=7,
DEC=8,
LD=11,
STO=12,
JE=14,
JNE=15,
HALT=18,
DECODE=2,
CMP=5,
MOV=6,
SHL=9,
SHR=10,
LDI=13,
JC=16, 
JMP=17,
ILLEGAL_OP=31;

/*********************************
*
301 Control Unit Sequencer *
*********************************/
// synchronous state register assignment
always @(posedge clk or posedge reset)
if (reset)
state = RESET;
else
state = nextstate;
// synchronous flags register assignment
always @(posedge clk or posedge reset)
if (reset)
{ps_N,ps_Z,ps_C} = 3'b0;
else
{ps_N,ps_Z,ps_C} = {ns_N,ns_Z,ns_C};
// combinational logic section for both next state logic
// and control word for cpu_execution_unit and memory
always @( state )
case ( state )
RESET:
begin
// Default Control Word Values -- LED pattern = 1111_111
W_Adr= 3'b000; 
R_Adr = 3'b000; 
S_Adr = 3'b000;
adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b0;
alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = 3'b0;
status = 8'hFF;
nextstate = FETCH;
end
FETCH: begin
// IR <-- M[PC],
//PC <- PC+1 -- LED pattern = 1000_000
W_Adr= 3'b000; 
R_Adr = 3'b000; 
S_Adr = 3'b000;
adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b1;
pc_sel=1'b0;
ir_ld = 1'b1;
mw_en= 1'b0;
rw_en = 1'b0;
alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = 8'h80;
nextstate = DECODE;
end
DECODE: begin
// Default Control Word Values -- LED pattern = 1100_0000
W_Adr= 3'b000; 
R_Adr = 3'b000; 
S_Adr = 3'b000;
adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b0;
alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = 8'hC0;
case ( IR[15:12] )
4'b0000: nextstate = ADD;
4'b0001: nextstate = SUB;
4'b0010: nextstate = CMP;
4'b0011: nextstate = MOV;
4'b0100: nextstate = SHL;
4'b0101: nextstate = SHR;
4'b0110: nextstate = INC;
4'b0111: nextstate = DEC;
4'b1000: nextstate = LD;
4'b1001: nextstate = STO;
4'b1010: nextstate = LDI;
4'b1011: nextstate = HALT;
4'b1100: nextstate = JE;
4'b1101: nextstate = JNE;
4'b1110: nextstate = JC;
4'b1111: nextstate = JMP;
default: nextstate = ILLEGAL_OP;
endcase
end
ADD: begin
// R[ir(8:6)] <-- R[ir(5:3)] + R[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b00000}
// PUT CONTROL WORD FOR EXECUTION OF ADD HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[5:3]; 
S_Adr = IR[2:0];

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0010;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00000};
nextstate = FETCH;
// go back to fetch
end
SUB: begin
// R[ir(8:6)] <-- R[ir(5:3)] - R[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b00001}
// PUT CONTROL WORD FOR EXECUTION OF SUB HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[5:3]; 
S_Adr = IR[2:0];

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0011;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00001};
nextstate = FETCH;
// go back to fetch
end
CMP: begin
// R[ir(5:3)] - R[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b00010}
// PUT CONTROL WORD FOR EXECUTION OF CMP HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[5:3]; 
S_Adr = IR[2:0];

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b0;

alu_op = 4'b0011; // substract
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00010};
nextstate = FETCH;
// go back to fetch
end
MOV: begin
// R[ir(8:6)] <-- R[ir(2:0)] -- LED pattern = {ns_N,ns_Z,ns_C,5'b00011}
// PUT CONTROL WORD FOR EXECUTION OF MOV HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status ={ns_N,ns_Z,ns_C,5'b00011};
nextstate = FETCH;
// go back to fetch
end
SHL: begin
// R[ir(8:6)] <-- R[ir(2:0)] << 1 -- LED pattern = {ps_N,ps_Z,ps_C,5'b00100}
// PUT CONTROL WORD FOR EXECUTION OF SHL HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0111;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00100};
nextstate = FETCH;
// go back to fetch
end
SHR: begin
// R[ir(8:6)] <-- R[ir(2:0)] >> 1 -- LED pattern = {ps_N,ps_Z,ps_C,5'b00101}
// PUT CONTROL WORD FOR EXECUTION OF SHR HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0110;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00101};
nextstate = FETCH;
// go back to fetch
end
INC: begin
// R[ir(8:6)] <-- R[ir(2:0)] + 1 -- LED pattern = {ps_N,ps_Z,ps_C,5'b00110}
// PUT CONTROL WORD FOR EXECUTION OF INC HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0100;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00110};

nextstate = FETCH;
// go back to fetch
end
DEC: begin
// R[ir(8:6)] <-- R[ir(2:0)] - 1 -- LED pattern = {ps_N,ps_Z,ps_C,5'b00111}
// PUT CONTROL WORD FOR EXECUTION OF DEC HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0101;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b00111};
nextstate = FETCH;
// go back to fetch
end
LD:
begin
// R[ir(8:6)] <-- M[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01000}
// PUT CONTROL WORD FOR EXECUTION OF LOAD HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b1;
s_sel = 1'b1;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel = 1'b1;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0001;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01000};
nextstate = FETCH;
// go back to fetch
end
STO: begin
// M[ir(8:6)] <-- R[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01001}
// PUT CONTROL WORD FOR EXECUTION OF STO HERE!!!
W_Adr = IR[8:6]; 
R_Adr = IR[8:6]; 
S_Adr = IR[2:0];

adr_sel = 1'b1;
s_sel = 1'b0;
pc_ld= 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b1;
rw_en = 1'b0;

alu_op = 4'b0001; // pass S
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01001};
nextstate = FETCH;
// go back to fetch
end
LDI: begin
// R[ir(8:6)] <-- M[PC], PC <-- PC + 1 -- LED pattern = {ps_N,ps_Z,ps_C,5'b01010}
// PUT CONTROL WORD FOR EXECUTION OF LDI HERE!!!
W_Adr = IR[8:6]; 
R_Adr = 3'bx; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b1;
pc_ld= 1'b0;
pc_inc = 1'b1;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en= 1'b0;
rw_en = 1'b1;

alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01010};
nextstate = FETCH;
// go back to fetch
end
JE: begin
// if (ps_Z=1) PC <-- PC + se_IR[7:0] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01100}
// PUT CONTROL WORD FOR EXECUTION OF JE HERE!!!
if(ps_N == 1)
begin
	pc_ld = 1;
end
else
begin
	pc_ld = 0;
end
W_Adr = 3'bx; 
R_Adr = 3'bx; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;

pc_inc = 1'b0;
pc_sel= 1'b0;
ir_ld = 1'b0;
mw_en = 1'b0;
rw_en = 1'b0;

alu_op = 4'bx;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01100};

nextstate = FETCH;
end
JNE: begin
// if (ps_Z=0) PC <-- PC + se_IR[7:0] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01101}
// PUT CONTROL WORD FOR EXECUTION OF JNE HERE!!!
if(ps_Z == 0)
begin
	pc_ld = 1;
end
else
begin
	pc_ld = 0;
end
W_Adr = 3'bx; 
R_Adr = 3'bx; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;

pc_inc = 1'b0;
pc_sel= 1'b0;
ir_ld = 1'b0;
mw_en = 1'b0;
rw_en = 1'b0;

alu_op = 4'bx;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01101};

nextstate = FETCH;
end
JC: begin
// if (ps_C=1) PC <-- PC + se_IR[7:0] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01110}
// PUT CONTROL WORD FOR EXECUTION OF JC HERE!!!
if(ps_C == 1)
begin
	pc_ld = 1;
end
else
begin
	pc_ld = 0;
end
W_Adr = 3'bx; 
R_Adr = 3'bx; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;

pc_inc = 1'b0;
pc_sel= 1'b0;
ir_ld = 1'b0;
mw_en = 1'b0;
rw_en = 1'b1;

alu_op = 4'bx;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01110};

nextstate = FETCH;
end
JMP: begin
// PC <-- R[ir(2:0)] -- LED pattern = {ps_N,ps_Z,ps_C,5'b01111}
// PUT CONTROL WORD FOR EXECUTION OF JMP HERE!!!
W_Adr = 3'bx; 
R_Adr = IR[2:0]; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld = 1'b1;
pc_inc = 1'b0;
pc_sel=1'b1;
ir_ld = 1'b0;
mw_en = 1'b0;
rw_en = 1'b0;

alu_op = 4'b0000;
{ns_N,ns_Z,ns_C} = {ps_N,ps_Z,ps_C};
// flags remain the same
status = {ps_N,ps_Z,ps_C,5'b01111};


nextstate = FETCH;
end
HALT: begin
// Default Control Word Values -- LED pattern = {ps_N,ps_Z,ps_C,5'b01011}
// PUT CONTROL WORD FOR HALT HERE!!!
W_Adr = 3'bx; 
R_Adr = 3'bx; 
S_Adr = 3'bx;

adr_sel = 1'b0;
s_sel = 1'b0;
pc_ld = 1'b0;
pc_inc = 1'b0;
pc_sel=1'b0;
ir_ld = 1'b0;
mw_en = 1'b0;
rw_en = 1'b0;

alu_op = 4'b1111;
{ns_N,ns_Z,ns_C} = {ns_N,ns_Z,ns_C};
status = {ps_N,ps_Z,ps_C,5'b01011};
nextstate = HALT;
// loop here forever
end
ILLEGAL_OP:
begin // Default Control Word Values -- LED pattern = 1111_0000
// PUT CONTROL WORD FOR ILLEGAL OPCODE HERE!!!
status = 8'b11110000;
nextstate = ILLEGAL_OP;
// loop here forever
end
endcase


endmodule
