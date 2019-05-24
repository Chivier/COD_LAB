`include "define.v"
`timescale 1ns / 1ps

module alu (input wire [`EXE_BUS] aluop,
            input wire [`REG_BUS] numa,
            input wire [`REG_BUS] numb,
            output reg [`REG_BUS] num_out,
            output reg iszero);

always @* begin
    case (aluop)
        `EXE_ADD : num_out = numa + numb;
        `EXE_SUB : num_out = numa - numb;
        `EXE_CMP : num_out = numa == numb ? 1 : 0;
        `EXE_SLT : num_out = numa <  numb ? 1 : 0;
        `EXE_NOR : num_out = ~ numa;
        `EXE_OR  : num_out = numa | numb;
        `EXE_AND : num_out = numa & numb;
        `EXE_XOR : num_out = numa ^ numb;
        `EXE_NOP : num_out = numa;
    endcase
end

always @* begin
    iszero = (num_out == 0 ? 1 : 0);
end
endmodule
