`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:28:38 06/05/2018
// Design Name:
// Module Name:    DataRam
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
module DataRam(
	input clk,
	input [31:0]addr,
	input [31:0]din,
	input we,
	input [1:0]LwByte,
	output reg[31:0]dout
    );
	reg [31:0]Mem[0:63];

	wire [4:0]A;
	wire [31:0]out;
	//wire [31:0] dout0;
	//wire [15:0] dout1;
	//wire [7:0]  dout2;

	assign A=(addr>>2);
	assign out=Mem[A];

	always@(*)
   begin
		case(LwByte)
			2'b00 :dout<= out;
			2'b01 :dout<= {{16{out[31]}},out[31:16]};
         2'b10 :dout<= {{24{out[31]}},out[31:24]};
			default :dout<= 0;
		endcase
	end


	always@(posedge clk)
	begin
		if(we)
			Mem[A]<=din;
	end


	initial
	begin
		$readmemh("E:/test/pipe/dmem.txt",Mem);
	end

endmodule
