`include "define.v"
`timescale 1ns / 1ps

module alu_ctrl (input wire[`OP_BUS] opcode,
input wire [`FUNT_BUS] funt,
output reg [`EXE_BUS] alu_op);

always @* begin
case (opcode)
     `OP_R_TYPE : begin
     case (funt)
     `FUNC_ADD : alu_op = `EXE_ADD;
     `FUNC_SUB : alu_op = `EXE_SUB;
     `FUNC_AND : alu_op = `EXE_AND;
     `FUNC_OR  : alu_op = `EXE_OR;
     `FUNC_XOR : alu_op = `EXE_XOR;
     `FUNC_NOR : alu_op = `EXE_NOR;
     `FUNC_SLT : alu_op = `EXE_SLT;
     endcase
     end
     `OP_ADDI : alu_op = `EXE_ADD;
     `OP_ANDI : alu_op = `EXE_AND;
     `OP_ORI  : alu_op = `EXE_OR;
     `OP_XORI : alu_op = `EXE_XOR;
     `OP_LW   : alu_op = `EXE_ADD;
     `OP_SW   : alu_op = `EXE_ADD;
     `OP_BEQ  : alu_op = `EXE_CMP;
     `OP_BNE  : alu_op = `EXE_CMP;
     `OP_SLTI : alu_op = `EXE_SLT;
     `OP_J    : alu_op = `EXE_NOP;
     endcase
end

endmodule