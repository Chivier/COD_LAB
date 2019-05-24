`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 22:14:52
// Design Name: 
// Module Name: CMP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "DEFINE.v"
module CMP(
    input [`OPERAND_BUS] A,
    input [`OPERAND_BUS] B,
    output reg C
    );
    reg [`OPECODE_BUS] SUB;
    wire [`OPERAND_BUS] CT;
    wire [`OPECODE_BUS] F;
    
    initial SUB = `EXE_SUB;
    
    ALU ALUER(SUB,A,B,CT,F);
    
    always @* C = F[2];
endmodule
