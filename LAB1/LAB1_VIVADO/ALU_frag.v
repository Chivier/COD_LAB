`include "DEFINE.v"
module ALU_OR (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = A | B;
	assign F = 0;
endmodule

module ALU_AND (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = A & B;
	assign F = 0;
endmodule

module ALU_NOT (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = ~A;
	assign F = 0;
endmodule

module ALU_XOR (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = A ^ B;
	assign F = 0;
endmodule

module ALU_LST (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign F = (A >> `OPERAND_LIM) ? 1 : 0;
	assign C = A << 1;
endmodule

module ALU_RST (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = A >> 1;
	assign F = 0;
endmodule

module ALU_ADD (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign {F,C} = A + B;
endmodule

module ALU_SUB (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign {F,C} = A - B;
endmodule

module ALU_MUT (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign {F,C} = A * B;
endmodule

module ALU_DIV (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign {F,C} = A / B;
endmodule

module ALU_OPP (
	input  [`OPERAND_BUS] A,
	input  [`OPERAND_BUS] B,
	output [`OPERAND_BUS] C,
	output F
	);
	assign C = -A;
	assign F = 0;
endmodule