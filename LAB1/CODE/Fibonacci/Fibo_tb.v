    `timescale 1ns / 1ps

`include "DEFINE.v"

module Fibo_tb (
    );
    
   reg CLOCK_50;
   reg rst;

    reg  [`OPECODE_BUS] OP;
    reg  [`OPERAND_BUS] A;
    reg  [`OPERAND_BUS] B;
    wire  [`OPERAND_BUS] C;

   initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;    
   end
   
   initial begin
       A = 6'b01;
       B = 6'b10;
    rst = 0;
    #100 rst = 1;
    #10  rst = 0;
        
    #500 $stop;
   end
   
   Fibonacci F(
    .clk(CLOCK_50),
    .rst(rst),
    .A(A),
    .B(B),
    .C(C)
   );
endmodule