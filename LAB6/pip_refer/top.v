`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:38:58 06/07/2018 
// Design Name: 
// Module Name:    top 
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
module top(
	input clk,
	input switch_en,
	input seq_en,
	input  [4:0] addr,
	output [3:0] an,
	output [7:0] seg
	);
	wire [15:0]data;
	
	CPUdl   U1(clk,switch_en,seq_en,addr,data);
   display U2(clk,data,seg,an);

endmodule




