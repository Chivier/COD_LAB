`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 21:42:25
// Design Name: 
// Module Name: counter_tb
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

`define PARAN 5
`define BUSN  4:0

module counter_tb(

    );
    
    reg [`BUSN] D;
    reg pe;
    reg ce;
    reg rst;
    reg clk;
    wire [`BUSN] Q;

    initial rst<=0;
    always #500 rst<=~rst;
 
    initial clk<=0;
    always #5 clk<=~clk; 

    initial
    begin
        #10 rst = 1;
        #10 rst = 0;
        #10 D   = 3;
            pe  = 1;
        #20 pe  = 0;
            ce  = 1;
        #30 D   = 0;
    end
    counter DUT (D,pe,ce,rst,clk,Q); 
endmodule
