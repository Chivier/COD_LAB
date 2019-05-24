`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 13:01:00
// Design Name: 
// Module Name: DIV_tb
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

 `timescale 1ns/1ns
module divider_module_tb  ; 

 reg  [7:0]  A   ; 
 reg  [7:0]  B   ; 
 wire  [7:0]  C   ; 
 wire  [7:0]  D   ; 
 reg    rst   ; 
 reg    clk   ; 
 
 initial
 begin
   rst<=0;
   #10 rst<=1;
 end
 
 initial clk<=0;
 always #5 clk<=~clk;
 initial
 begin
   A<=8'd127;
   B<=4'd2;
   #100
   A=8'd34;
   B=5;
   #100;
 end
 
 DIV DUT ( clk,rst,A,B,C,D); 

endmodule
