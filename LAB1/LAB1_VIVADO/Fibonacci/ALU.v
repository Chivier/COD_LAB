`timescale 1ns / 1ps

`include "DEFINE.v"

module ALU (
	input  [`OPECODE_BUS] OP,
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output reg [`OPERAND_BUS] C
	);

	always @* begin
			case (OP)
				`EXE_ORI: begin C <= A | B;  end
				`EXE_AND: begin C <= A & B;  end
				`EXE_NOT: begin C <= ~ A  ;  end
				`EXE_XOR: begin C <= A ^ B;  end
				`EXE_ADD: begin C <= A + B; end
				`EXE_SUB: begin C <= A - B; end
			endcase
	end
endmodule