`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/04/10 01:53:42
// Design Name:
// Module Name: FIFO
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module FIFO(
    input en_out,
    input [3:0] in,
    input en_in,
    input rst,
    input clk,
    input qclk,
    output reg [7:0] an,
    output reg [6:0] seg,
    output reg dp,
    output reg [3:0] out,
    output reg empty,
    output reg full/*,
    output [7:0] avail,
    output [3:0] front,
    output [3:0] rear,
    output [31:0] queue,
    output [3:0] num,
    output [12:0] count*/
    );

    wire clk5MHZ;
    wire clkp;
    //assign clk5MZ=clk;
    clk_wiz_0 cw1(clk5MHZ,clk);

    reg [3:0] Q [7:0];
    reg [7:0] avail;
    reg [3:0] front;
    reg [3:0] rear;
    integer i;
    //assign queue = {Q[0],Q[1],Q[2],Q[3],Q[4],Q[5],Q[6],Q[7]};
    always @(posedge qclk or negedge rst)
    begin
      if (rst)
      begin
        for (i = 0 ; i < 8 ; i = i + 1)
        Q[i] = 0;

        front = 0;
        rear  = 0;
        avail = 0;
        empty = 1;
        full  = 0;
      end
      else
      begin
        if (en_in)
        begin
            if (!avail[front])
            begin
                Q[front] = in;
                avail[front] = 1;
                front = (front + 1) % 8;
            end

            out = in;
        end

        if (en_out)
        begin
            if (avail[rear])
            begin
                out = Q[rear];
                Q[rear] = 0;
                avail[rear] = 0;
                rear = (rear + 1) % 8;
            end

        end

        if (avail == 8'b11111111)
        full = 1;
        else
        full = 0;

        if (avail == 8'b00000000)
        empty = 1;
        else
        empty = 0;
      end
    end


    reg [3:0] num;
    wire [6:0] seg0[7:0];
    reg [12:0] count ;
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
    an<=8'b11111111;
    clk1<=0;
    num<=0;
    count<=0;
    end

    always@(posedge clk5MHZ)
        if(count>=13'd1999)
        begin
            clk1<=~clk1;
            count=13'b0;
            num = (num+1)%8;
        end
        else
        count=count+1;

    always@*
    case(num)
        0:begin
            an <=8'b11111110;
            seg<=seg0[0];
            if (!avail[0])
            seg<=7'b1111111;

            if (rear == 0)
            dp <= 0;
            else
            dp <= 1;
          end
        1:begin
            an <=8'b11111101;
            seg<=seg0[1];
            if (!avail[1])
            seg<=7'b1111111;

            if (rear == 1)
            dp <= 0;
            else
            dp <= 1;
          end
        2:begin
            an <=8'b11111011;
            seg<=seg0[2];
            if (!avail[2])
            seg<=7'b1111111;

            if (rear == 2)
            dp <= 0;
            else
            dp <= 1;
          end
        3:begin
            an <=8'b11110111;
            seg<=seg0[3];
            if (!avail[3])
            seg<=7'b1111111;

            if (rear == 3)
            dp <= 0;
            else
            dp <= 1;
          end
        4:begin
            an <=8'b11101111;
            seg<=seg0[4];
            if (!avail[4])
            seg<=7'b1111111;

            if (rear == 4)
            dp <= 0;
            else
            dp <= 1;
          end
        5:begin
            an <=8'b11011111;
            seg<=seg0[5];
            if (!avail[5])
            seg<=7'b1111111;

            if (rear == 5)
            dp <= 0;
            else
            dp <= 1;
          end
        6:begin
            an <=8'b10111111;
            seg<=seg0[6];
            if (!avail[6])
            seg<=7'b1111111;

            if (rear == 6)
            dp <= 0;
            else
            dp <= 1;
          end
        7:begin
            an <=8'b01111111;
            seg<=seg0[7];
            if (!avail[7])
            seg<=7'b1111111;

            if (rear == 7)
            dp <= 0;
            else
            dp <= 1;
          end
    endcase
endmodule
