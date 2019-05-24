`timescale 1ns / 1ps

`include "DEFINE.v"

module ALU (
	input  [`OPECODE_BUS] OP,
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output reg [`OPERAND_BUS] C,
	output reg [`OPECODE_BUS] F
	);

	always @* begin
		case (OP)
			`EXE_ORI: begin C = A | B; F[2] = 0; F[1] = 0; F[0] = (C == 0); end
			`EXE_AND: begin C = A & B; F[2] = 0; F[1] = 0; F[0] = (C == 0);  end
			`EXE_NOT: begin C = ~ A  ; F[2] = 0; F[1] = 0; F[0] = (C == 0);  end
			`EXE_XOR: begin C = A ^ B; F[2] = 0; F[1] = 0; F[0] = (C == 0);  end
			`EXE_ADD: begin {F[2],C} = A + B; F[1] = A[`OPERAND_LIM] ^ B[`OPERAND_LIM] ^ C[`OPERAND_LIM] ^ F[2]; F[0] = (C == 0); end
			`EXE_SUB: begin {F[2],C} = A - B; F[1] = A[`OPERAND_LIM] ^ B[`OPERAND_LIM] ^ C[`OPERAND_LIM] ^ F[2]; F[0] = (C == 0); end
		endcase
	end
endmodule