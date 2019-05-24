`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 23:14:36
// Design Name: 
// Module Name: Sort_tb
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

module Sort_tb (
    );
    

    reg  [`OPERAND_BUS] A;
    reg  [`OPERAND_BUS] B;
    reg  [`OPERAND_BUS] C;
    reg  [`OPERAND_BUS] D;
    wire [`OPERAND_BUS] E;
    wire [`OPERAND_BUS] F;
    wire [`OPERAND_BUS] G;
    wire [`OPERAND_BUS] H;
    reg rst;
    
    initial begin
    rst = 0;
    forever #10 rst = ~rst; 
    end
    
   initial begin
    #50 A = 1; B = 2; C = 3; D = 4;
    #50 A = 5; B = 2; C = 3; D = 4;
    #50 A = 5; B = 2; C = 3; D = 3;
    #50 $stop;
   end
   
   Sort S(rst,A,B,C,D,E,F,G,H);
endmodule