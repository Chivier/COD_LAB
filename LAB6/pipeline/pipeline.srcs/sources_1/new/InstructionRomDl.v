`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:30:44 06/07/2018
// Design Name:
// Module Name:    InstructionRomDl
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
module InstructionROMDl(
	input [31:0]addr,
	output [31:0]dout
    );

	wire [4:0]A;
	assign A=(addr>>2);
	dist_mem_gen_0 Instr(.a(A),.spo(dout));


endmodule
