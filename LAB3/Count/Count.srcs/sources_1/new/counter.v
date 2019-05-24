`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 21:41:57
// Design Name: 
// Module Name: counter
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

module counter(
    input [`BUSN] D,
    input pe,
    input ce,
    input rst,
    input clk,
    output [`BUSN] Q
    );

    reg [`BUSN] RegCount;

    always @(posedge clk or negedge rst)
    begin
      if (rst)
        RegCount = 0;
      else
      begin
        if (pe)
          RegCount = D;
        else
        begin
          if (ce)
          RegCount = RegCount + 1;
        end
      end
    end

    assign Q = RegCount;
endmodule
