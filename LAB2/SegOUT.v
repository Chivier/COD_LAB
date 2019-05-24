`timescale 1ns / 1ps

module Seg(
	input [3:0] a,
	output reg [0:6] seg);
	always@*
	begin
    case (a)
        4'd0:begin  seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=1; end
        4'd1:begin  seg[0]=1;seg[1]=0;seg[2]=0;seg[3]=1;
        			seg[4]=1;seg[5]=1;seg[6]=1; end
        4'd2:begin  seg[0]=0;seg[1]=0;seg[2]=1;seg[3]=0;
        			seg[4]=0;seg[5]=1;seg[6]=0; end
        4'd3:begin  seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=0;
        			seg[4]=1;seg[5]=1;seg[6]=0; end
        4'd4:begin  seg[0]=1;seg[1]=0;seg[2]=0;seg[3]=1;
        			seg[4]=1;seg[5]=0;seg[6]=0; end
        4'd5:begin  seg[0]=0;seg[1]=1;seg[2]=0;seg[3]=0;
        			seg[4]=1;seg[5]=0;seg[6]=0; end
        4'd6:begin  seg[0]=0;seg[1]=1;seg[2]=0;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=0; end
        4'd7:begin  seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=1;
        			seg[4]=1;seg[5]=1;seg[6]=1; end
        4'd8:begin  seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=0; end
        4'd9:begin  seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=0;
        			seg[4]=1;seg[5]=0;seg[6]=0; end
        4'd10:begin seg[0]=0;seg[1]=0;seg[2]=0;seg[3]=1;
        			seg[4]=0;seg[5]=0;seg[6]=0; end//A
        4'd11:begin seg[0]=1;seg[1]=1;seg[2]=0;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=0; end//b
        4'd12:begin seg[0]=0;seg[1]=1;seg[2]=1;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=1; end//C
        4'd13:begin seg[0]=1;seg[1]=0;seg[2]=0;seg[3]=0;
        			seg[4]=0;seg[5]=1;seg[6]=0; end//d
        4'd14:begin seg[0]=0;seg[1]=1;seg[2]=1;seg[3]=0;
        			seg[4]=0;seg[5]=0;seg[6]=0; end//E
        4'd15:begin seg[0]=0;seg[1]=1;seg[2]=1;seg[3]=1;
        			seg[4]=0;seg[5]=0;seg[6]=0; end//F
        default:seg=7'b0000000;
    endcase
	end
endmodule

module counter #(parameter cnt=9)
    (
    input clk,
    input enable,
    input reset,
    output carry,
    output reg [3:0] Q
    );
    assign carry=(Q==cnt)?1:0;
    initial
    begin
    Q<=0;
    end
    always@(posedge clk,posedge reset)
    begin
        if(reset)
        Q<=0;
        else if(enable)
        if(Q>=cnt)
            Q<=0;
        else
            Q=Q+1;
    end

endmodule

module segOutput(
    input clk5MHZ,
    input [3:0] Q0,
    input [3:0] Q1,
    input [3:0] Q2,
    input [3:0] Q3,
    output reg [7:0] an,
    output reg [7:0] seg,
    output dp
    );
    wire [3:0] num;
    wire [7:0] seg0,seg1,seg2,seg3;
    reg clk;
    reg [12:0] count ;

    Seg b0(Q0,seg0);
    Seg b1(Q1,seg1);
    Seg b2(Q2,seg2);
    Seg b3(Q3,seg3);
    initial
    begin
    an<=8'b11111111;
    clk<=0;
    count<=0;
    end
    always@(posedge clk5MHZ)
        if(count>=13'd4999)
        begin
            clk<=~clk;
            count=13'b0;
        end
        else
        count=count+1;
    counter#(3) c(clk,1,,,num);
    always@(num)
    case(num)
        0:begin
        an<=8'b00000001;
        seg<=seg0;
        end
        1:begin
        an<=8'b00000010;
        seg<=seg1;
        end
        2:begin
        an<=8'b00000100;
        seg<=seg1;
        end
        3:begin
        an<=8'b00001000;
        seg<=seg1;
        end
    endcase
endmodule

module SegOUT (
    input CLK100MHZ,
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    output [7:0] an,
    output [7:0] seg)
begin
    wire clk0,locked,reset,clk_out1,JW1,JW2;
    integer clk1;
    wire [0:6] seg1,seg2,seg3,seg4;
    clk_wiz0 C1(.clk_in1(CLK100MHZ),.reset(reset),
    			.clk_out1(clk_out1),.locked(locked));
    clock C2(clk_out1,locked,clk0);
    numclock C3(clk_out1,locked,clk1);
    Seg s1(A[3:0],seg1[0:6]);
    Seg s2(B[3:0],seg2[0:6]);
    Seg s2(C[3:0],seg3[0:6]);
    Seg s2(D[3:0],seg4[0:6]);
    segOutput so(clk5MHZ,seg1,seg2,seg3,seg4,an,seg);
end
