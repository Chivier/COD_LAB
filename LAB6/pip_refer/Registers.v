`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:11 06/04/2018 
// Design Name: 
// Module Name:    Registers 
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
module Registers(
	input clk,
	input [4:0]RsAddr,
	input [4:0]RtAddr,
	input [31:0]WriteData,
	input [4:0]WriteAddr,
	input RegWrite,
	output [31:0]RsData,
	output [31:0]RtData
    );
	 
	reg [31:0]Regs[0:31];
	
	assign RsData=(RsAddr==5'b0) ? 32'b0 : Regs[RsAddr];
	assign RtData=(RtAddr==5'b0) ? 32'b0 : Regs[RtAddr];
	
	always@(posedge clk) 
	begin  
		if(RegWrite)    
			Regs[WriteAddr]<=WriteData;  
	end 
	
	initial
	begin
	   Regs[0]=0;
		Regs[1]=0;
		Regs[2]=0;
		Regs[3]=0;
		Regs[4]=0;
		Regs[5]=0;
		Regs[6]=0;
		Regs[7]=0;
		Regs[8]=0;
		Regs[9]=0;
		Regs[10]=0;
		Regs[11]=0;
		Regs[12]=0;
		Regs[13]=0;
		Regs[14]=0;
		Regs[15]=0;
		Regs[16]=0;
		Regs[17]=0;
		Regs[18]=0;
		Regs[19]=0;
		Regs[20]=0;
		Regs[21]=0;
		Regs[22]=0;
		Regs[23]=0;
		Regs[24]=0;
		Regs[25]=0;
		Regs[26]=0;
		Regs[27]=0;
		Regs[28]=0;
		Regs[29]=0;
		Regs[30]=0;
		//Regs[31]=0;
	end
	
	
endmodule
