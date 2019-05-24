`timescale 1ns / 1ps

`include "DEFINE.v"

module CMP (
	input  clk,
	input  rst,
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output reg C
	);
    
    reg [`OPERAND_BUS] TMP;
    reg [`OPECODE_BUS] FLAG;
    
    ALU aluer (clk,rst,`EXE_SUB,A,B,TMP,FLAG);
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			C = 0;
		end
		else
		begin
		
		end
	end
endmodule