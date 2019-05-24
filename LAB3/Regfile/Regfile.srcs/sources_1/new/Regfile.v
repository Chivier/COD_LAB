`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 11:02:39
// Design Name: 
// Module Name: Regfile
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
(* use_dsp = "yes" *)

module Regfile(
    input  [`BUSM] Ra0,
    input  [`BUSM] Ra1,
    input  [`BUSM] Wa,
    input  [`BUSN] Wd,
    input          We,
    input          rst,
    input          clk,
    output [`BUSN] Rd0,
    output [`BUSN] Rd1
    );

    reg [`BUSN] Regs [`BUSREG];
    integer i;

    always @(posedge clk or negedge rst)
    begin
      if (rst)
      begin
        for (i = 0 ; i < 8 ; i = i + 1 )
            Regs[i] <= 0;
      end
      else
      if (We)
      Regs[Wa] = Wd;
    end

    assign Rd0 = Regs[Ra0];
    assign Rd1 = Regs[Ra1];
endmodule
