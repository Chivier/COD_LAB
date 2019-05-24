`timescale 1ns / 1ps

module BCD27(input [3:0]m,
             output [6:0] out);
reg[6:0]seg;
assign out = seg;
always@(m)
    case(m)
        //---------------1234567
        4'b0000:seg = 7'b1000000; // 0
        4'b0001:seg = 7'b1111001; // 1
        4'b0010:seg = 7'b0100100; // 2
        4'b0011:seg = 7'b0110000; // 3
        4'b0100:seg = 7'b0011001; // 4
        4'b0101:seg = 7'b0010010; // 5
        4'b0110:seg = 7'b0000010; // 6
        4'b0111:seg = 7'b1111000; // 7
        4'b1000:seg = 7'b0000000; // 8
        4'b1001:seg = 7'b0010000; // 9
        4'b1010:seg = 7'b0001000; // A
        4'b1011:seg = 7'b0000011; // b
        4'b1100:seg = 7'b1000110; // c
        4'b1101:seg = 7'b0100001; // d
        4'b1110:seg = 7'b0000110; // E
        4'b1111:seg = 7'b0001110; // F
        default:seg = 7'b1111111;
    endcase
    end
endmodule