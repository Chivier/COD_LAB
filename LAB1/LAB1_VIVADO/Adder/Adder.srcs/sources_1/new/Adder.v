`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 21:47:04
// Design Name: 
// Module Name: Adder
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


module Adder(
    input clk,
    input rst,
    input [5:0] A,
    output reg [5:0] B
    );
    
    reg [`OPERAND_BUS] TMP;
    reg [`OPECODE_BUS] ADD;
    reg [`OPERAND_BUS] T;
    wire [`OPERAND_BUS] CT;
    
    always @* T <= TMP;
    initial ADD = `EXE_ADD;
        
    ALU ALUER(ADD,A,TMP,CT);
    always @(posedge clk or posedge rst) begin
       if (rst) begin
               TMP = 0;
            end
            else
            begin
               TMP = CT;
            end
    end
        
    always @*
    B <= CT;
endmodule
