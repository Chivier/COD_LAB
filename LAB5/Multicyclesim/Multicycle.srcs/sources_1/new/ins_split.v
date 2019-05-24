`include "define.v"
`timescale 1ns / 1ps

//* Instruction spliter
//* Opcode 31:26
//* num1   25:21
//* num2   20:16
//* num3   15: 0

module ins_split (
input wire ir_write,
input wire [`REG_BUS] ins,
                  output reg [`OP_BUS] opcode,
                  output reg [`RS_BUS] num1,
                  output reg [`RT_BUS] num2,
                  output reg [`NUM3_BUS] num3,
                  output reg [`RD_BUS] num4,
                  output reg [`NUM5_BUS] num5,
                  output reg [`NUM6_BUS] num6,
                  output wire [`REG_BUS] irrun);

reg[`REG_BUS] ir;
always @* begin
    if (ir_write) ir = ins;
    opcode = {ir[`OPCODE_BUS]};
    num1   = {ir[`NUM1_BUS]};
    num2   = {ir[`NUM2_BUS]};
    num3   = {ir[`NUM3_BUS]};
    num4   = {ir[`NUM4_BUS]};
    num5   = {ir[`NUM5_BUS]};
    num6   = {ir[`NUM6_BUS]};
end

assign irrun = ir;
endmodule
