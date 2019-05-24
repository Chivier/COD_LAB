`timescale 1ns / 1ps

`include "DEFINE.v"

module ALU_tb (
	);
	
   reg CLOCK_50;
   reg rst;
   initial begin
   	$dumpfile("ALU.vcd");
   	$dumpvars(0, ALU_tb);
   end

	reg  [`OPECODE_BUS] OP;
	reg  [`OPERAND_BUS] A;
	reg  [`OPERAND_BUS] B;
    wire  [`OPERAND_BUS] C;
    wire  F;
    wire  ZERO_FLAG;

   initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
   end
   initial
  $monitor("At time %t, A = %d , B = %d , C = %d , F = %d , ZERO_FLAG = %d", $time, A,B,C,F,ZERO_FLAG);
      
   initial begin
    rst = 0;
    #195 rst= 1;
    #10 OP = 4'b0011;
    	A = 6'b01000;
    	B = 6'b00111;
    #450 $stop;
   end
   
   ALU aluer(
   	.clk(CLOCK_50),
   	.rst(rst),
   	.OP(OP),
   	.A(A),
   	.B(B),
   	.C(C),
   	.F(F),
   	.ZERO_FLAG(ZERO_FLAG)
   );
endmodule