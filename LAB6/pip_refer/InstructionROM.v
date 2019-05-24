`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:57 06/05/2018 
// Design Name: 
// Module Name:    InstructionROM 
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
module InstructionROM(
	input [31:0]addr,
	output [31:0]dout
    );
	reg [31:0]Instr[0:63];
	wire [5:0]A;
	assign A=(addr>>2);
	assign dout=Instr[A];
	
	initial
	begin
	$readmemh("E:/test/instr/imemmy.txt",Instr);
	end 
	
endmodule