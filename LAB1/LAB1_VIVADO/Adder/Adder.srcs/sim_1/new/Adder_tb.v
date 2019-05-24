`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 21:53:28
// Design Name: 
// Module Name: Adder_tb
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

module Adder_tb (
    );
    
   reg CLOCK_50;
   reg rst;

    reg  [`OPECODE_BUS] OP;
    reg  [`OPERAND_BUS] A;
    wire  [`OPERAND_BUS] B;

   initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;    
   end
   
   initial begin
    A = 6'b01;
       
    rst = 0;
    #100 rst = 1;
    #10  rst = 0;
    #20  A = 6'b01;
    #20  A = 6'b11;
    #20  A = 6'b10;
    #20  A = 6'b01;
    #20  A = 6'b11;
    #20  A = 6'b10;
    #20  A = 6'b11;
    #20  A = 6'b10;
    #100 $stop;
   end
   
   Adder Add(
    .clk(CLOCK_50),
    .rst(rst),
    .A(A),
    .B(B)
   );
endmodule
