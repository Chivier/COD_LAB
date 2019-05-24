`include "define.v"
`timescale 1ns / 1ps

module mux2(input wire select,
            input wire [`REG_BUS] route1,
            input wire [`REG_BUS] route2,
            output reg [`REG_BUS] outdata);

    always @*
    if (select)
        outdata = route1;
    else
        outdata = route2;

endmodule
