`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 20:21:46
// Design Name: 
// Module Name: RegSim
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

`define PARA_M 3 //address 3bits
`define PARA_N 4 //data    4bits
`define BUSM   2:0
`define BUSN   3:0
`define BUSREG 7:0
module RegSim;
 reg  [`BUSM] Ra0;
 reg  [`BUSM] Ra1;
 reg  [`BUSM] Wa;
 reg  [`BUSN] Wd;
 reg          We;
 wire [`BUSN] Rd0;
 wire [`BUSN] Rd1;
 reg rst; 
 reg clk; 

 initial rst<=0;
 always #500 rst<=~rst;
 
 initial clk<=0;
 always #5 clk<=~clk; 
 
 initial
 begin
   Ra0=0;
   Ra1=0;
   Wa =1;
   We =1;
   Wd =10;
   #25

   Ra0=0;
   Ra1=0;
   Wa =2;
   We =1;
   Wd =7;
   #25

   Ra0=1;
   Ra1=2;
   Wa =2;
   We =0;
   Wd =0;
   #25;
 end
 
 Regfile DUT (Ra0,Ra1,Wa,Wd,We,rst,clk,Rd0,Rd1); 
endmodule
