`include "define.v"
`timescale 1ns / 1ps

module mem (input wire clk,
            input wire memwrite,
            input wire [`REG_BUS] indata,
            input wire [`REG_BUS] addr,
            output wire [`REG_BUS] memdata,
            input wire [`REG_BUS] dpra,
            output wire [`REG_BUS] dpo);

    dist_mem_gen_0 memorys (.a(addr), .d(indata), .clk(clk), .we(memwrite), .spo(memdata), .dpra(dpra), .dpo(dpo));

endmodule
