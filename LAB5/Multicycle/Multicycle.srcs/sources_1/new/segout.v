`include "define.v"
`timescale 1ns / 1ps

module segout (input wire clk,
               input wire [`REG_BUS] indata,
               output reg [7:0] an,
               output reg [6:0] seg);

    reg [3:0] Q [7:0];
    reg [3:0] num;
    wire [6:0] seg0[7:0];
    reg [31:0] count;
    reg clk1;

    BCD27 B0(Q[0],seg0[0]);
    BCD27 B1(Q[1],seg0[1]);
    BCD27 B2(Q[2],seg0[2]);
    BCD27 B3(Q[3],seg0[3]);
    BCD27 B4(Q[4],seg0[4]);
    BCD27 B5(Q[5],seg0[5]);
    BCD27 B6(Q[6],seg0[6]);
    BCD27 B7(Q[7],seg0[7]);

    initial
    begin
        an    <= 8'b11111111;
        clk1  <= 0;
        num   <= 0;
        count <= 0;
    end

    always @*
    begin
    Q[7] <= {indata[31:28]};//(indata & 32'b1111_0000_0000_0000_0000_0000_0000_0000) >> 28;
    Q[6] <= {indata[27:24]};// (indata & 32'b0000_1111_0000_0000_0000_0000_0000_0000) >> 24;
    Q[5] <= {indata[23:20]};// (indata & 32'b0000_0000_1111_0000_0000_0000_0000_0000) >> 20;
    Q[4] <= {indata[19:16]};// (indata & 32'b0000_0000_0000_1111_0000_0000_0000_0000) >> 16;
    Q[3] <= {indata[15:12]};// (indata & 32'b0000_0000_0000_0000_1111_0000_0000_0000) >> 12;
    Q[2] <= {indata[11: 8]};// (indata & 32'b0000_0000_0000_0000_0000_1111_0000_0000) >>  8;
    Q[1] <= {indata[7: 4]};// (indata & 32'b0000_0000_0000_0000_0000_0000_1111_0000) >>  4;
    Q[0] <= {indata[3: 0]};// (indata & 32'b0000_0000_0000_0000_0000_0000_0000_1111);
    end

    always@(posedge clk)
        if (count> = 31'd19999)
        begin
            clk1 <= ~clk1;
            count = 31'b0;
            num <= (num+1)%8;
        end
        else
            count = count+1;

    always@*
    case(num)
        0:begin
            an  <= 8'b11111110;
            seg <= seg0[0];
        end
        1:begin
            an  <= 8'b11111101;
            seg <= seg0[1];
        end
        2:begin
            an  <= 8'b11111011;
            seg <= seg0[2];
        end
        3:begin
            an  <= 8'b11110111;
            seg <= seg0[3];
        end
        4:begin
            an  <= 8'b11101111;
            seg <= seg0[4];
        end
        5:begin
            an  <= 8'b11011111;
            seg <= seg0[5];
        end
        6:begin
            an  <= 8'b10111111;
            seg <= seg0[6];
        end
        7:begin
            an  <= 8'b01111111;
            seg <= seg0[7];
        end
    endcase
endmodule
