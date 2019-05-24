`timescale 1ns / 1ps

module Fibonacci (
	input clk,
	input rst,
	input [`OPERAND_BUS] A,
    input [`OPERAND_BUS] B,
    output reg [`OPERAND_BUS] C
	);
    reg [`OPERAND_BUS] TMP1,TMP2;
    reg [`OPECODE_BUS] ADD;
	reg [`OPERAND_BUS] AT;
	reg [`OPERAND_BUS] BT;
	wire [`OPERAND_BUS] CT;
	
    
    always @* AT <= TMP1;
    always @* BT <= TMP2;
    initial ADD = `EXE_ADD;
    
    ALU ALUER(ADD,AT,BT,CT);
	always @(posedge clk or posedge rst) begin
	   if (rst) begin
	           TMP1 <= A;
	           TMP2 <= B;
            end
            else
            begin
               TMP1 <= TMP2;
               TMP2 <= CT;
            end
	end
	
	always @*
	C <= CT;
endmodule