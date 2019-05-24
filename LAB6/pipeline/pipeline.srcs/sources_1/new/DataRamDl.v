`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:30:24 06/07/2018
// Design Name:
// Module Name:    DataRamDl
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module DataRamDl(
	input clk,
	input [31:0]addr,
	input [31:0]din,
	input we,
	input [31:0] dduaddr,
	output [31:0] dduout,
	output [31:0]dout
    );

	wire [4:0]A;
	assign A=(addr>>2);
	dist_mem_gen_1 Mem(.a(A),.dpra(dduaddr),.d(din),.we(we),.clk(clk),.spo(dout),.dpo(dduout));


endmodule
