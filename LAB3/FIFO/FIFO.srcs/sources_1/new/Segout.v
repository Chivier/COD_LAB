module Segout(
    input clk5MHZ,
    input [3:0] Q[7:0],
    input [7:0] avail,
    input [3:0] rail,
    output reg [7:0] an,
    output reg [7:0] seg,
    output reg dp
    );
    wire [3:0] num;
    wire [7:0] seg0[7:0];
    reg clk;
    reg [12:0] count ;
    
    BCD27 B0(Q[0],0,seg[0]);
    BCD27 B1(Q[1],0,seg[1]);
    BCD27 B2(Q[2],0,seg[2]);
    BCD27 B3(Q[3],0,seg[3]);
    BCD27 B4(Q[4],0,seg[4]);
    BCD27 B5(Q[5],0,seg[5]);
    BCD27 B6(Q[6],0,seg[6]);
    BCD27 B7(Q[7],0,seg[7]);

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
    counter#(9) c(clk,1,,,num);
    always@(num)
    case(num)
        0:begin
            seg<=seg[0];
            dp<=0;
            if (avail[0])
                an<=8'b00000001;
            else
                an<=8'b00000000;
          end
        1:begin
            seg<=seg[1];
            dp<=0;
            if (avail[1])
                an<=8'b00000010;
            else
                an<=8'b00000000;
          end
        2:begin
            seg<=seg[2];
            dp<=0;
            if (avail[2])
                an<=8'b00000100;
            else
                an<=8'b00000000;
          end
        3:begin
            seg<=seg[3];
            dp<=0;
            if (avail[3])
                an<=8'b00001000;
            else
                an<=8'b00000000;
          end
        4:begin
            seg<=seg[4];
            dp<=0;
            if (avail[4])
                an<=8'b00010000;
            else
                an<=8'b00000000;
          end
        5:begin
            seg<=seg[5];
            dp<=0;
            if (avail[5])
                an<=8'b00100000;
            else
                an<=8'b00000000;
          end
        6:begin
            seg<=seg[6];
            dp<=0;
            if (avail[6])
                an<=8'b01000000;
            else
                an<=8'b00000000;
          end
        7:begin
            seg<=seg[7];
            dp<=0;
            if (avail[7])
                an<=8'b10000000;
            else
                an<=8'b00000000;
          end
        8:begin
            an<=(1<<rail);
            dp<=1;
            seg<=8'b11111111;
          end
    endcase
endmodule
