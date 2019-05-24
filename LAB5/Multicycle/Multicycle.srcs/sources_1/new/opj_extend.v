`include "define.v"
`timescale 1ns / 1ps

module opj_extend (input wire [`NUM5_BUS] ins,
                   input wire [`REG_BUS] pc,
                   output wire [`REG_BUS] extd);

assign extd = (ins << 2) | ((pc >> 28) << 28);

endmodule
