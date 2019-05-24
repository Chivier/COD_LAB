`include "define.v"
`timescale 1ns / 1ps

module extend(input wire [`NUM3_BUS] ins,
              output wire [`REG_BUS] extd);
assign
extd = 32'b0 | ins[`NUM3_BUS];

endmodule
