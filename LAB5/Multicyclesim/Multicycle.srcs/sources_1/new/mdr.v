`include "define.v"
`timescale 1ns / 1ps

module mdr (
input wire memread,
input wire [`REG_BUS] memdata,
output reg [`REG_BUS] memout);

reg [`REG_BUS] mem;

initial begin
mem = 0;
end


always @* begin
if (memread)
mem = memdata;
memout = mem;
end

endmodule

