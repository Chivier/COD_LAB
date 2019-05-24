`timescale 1ns / 1ps

module top(
	input clk,
	input switch_en,
	input seq_en,
	input  [7:0] adda,
	input  [7:0] addb,
	output [3:0] an,
	output [7:0] seg
	);

	wire [31:0]data;

	CPUdl   cpu  (clk,switch_en,seq_en,adda,addb,data);
    display segs (clk,data,seg,an);
endmodule
