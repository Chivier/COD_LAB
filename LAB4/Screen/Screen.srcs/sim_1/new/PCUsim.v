`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 20:51:32
// Design Name: 
// Module Name: PCUsim
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


module PCUsim;

    reg clk;
    reg rst;
    reg [`ColorBUS] Color;
    reg [  `DirBUS] Dir;
    reg DRAW;
    wire [`PenBUS] Storex;
    wire [`PenBUS] Storey;
    wire [`ColorBUS] Storecol;
    wire we;
    wire [`PenBUS] Penx;
    wire [`PenBUS] Peny;
    wire [`PenBUS] Xcor;
    wire [`PenBUS] Ycor;
    wire [`DirBUS] Dirdelay;
    wire [31:0] cu;
    wire [31:0] cl;
    wire [31:0] cr;
    wire [31:0] cd;
    wire Xflag;

    wire [`ColorBUS] Colorout;
    wire  O_hs;
    wire  O_vs;
    
    initial clk<=0;
    always #1 clk<=~clk;

    initial
    begin
      rst = 1; Dir = 0;
      #10 rst = 0;
      #10 rst = 1;
      #10 rst = 0;
      #20 DRAW = 1;
      #20 Color = 12'b1111_0000_0000;
      #20 Dir = 4'b_1000;
      #20 Dir = 4'b_0000;
      #10 DRAW = 0;
      #20 Dir = 4'b_0001;
      #20 Dir = 4'b_0000;
    end
    PCU DUT (clk,rst,Color,Dir,DRAW,/*Storex,Storey,Storecol,we,*/Penx,Peny,/*Dirdelay,cu,cl,cr,cd,Xcor,Ycor,Xflag*/Colorout,O_hs,O_vs);
endmodule