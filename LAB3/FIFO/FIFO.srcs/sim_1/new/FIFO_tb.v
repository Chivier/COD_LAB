`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/04/10 01:54:04
// Design Name:
// Module Name: FIFO_tb
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


module FIFO_tb;
    reg en_out;
    reg [3:0] in;
    reg en_in;
    reg rst;
    reg clk;
    reg qclk;
    wire [7:0] an;
    wire [7:0] seg;
    wire dp;
    wire [3:0] out;
    wire empty;
    wire full;
    wire [7:0]avail;
    wire [3:0]front;
    wire [3:0]rear;
    wire [31:0] Q;
    wire [3:0] num;
    wire [12:0] count;

    initial clk<=0;
    always #0.5 clk<=~clk;
    initial qclk<=0;
    always #5 qclk<=~qclk;

    initial
    begin
      rst = 1;
      #10 rst = 0;
      #10 rst = 1;
      #10 rst = 0;

      #10 en_in <= 1;
          in <= 9;
      #10 en_in <= 1;
          in <= 4;
      #20 en_in <= 0;
          en_out <= 1;

    end

    FIFO DUT (en_out,in,en_in,rst,clk,qclk,an,
              seg,dp,out,empty,full,avail,front,
              rear,Q,num,count);
endmodule
