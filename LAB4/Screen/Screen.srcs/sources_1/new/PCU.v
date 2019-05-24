`timescale 1ns / 1ps

`define ColorBUS 11:0
`define DirBUS   3:0
`define PenBUS   7:0

(* use_dsp = "yes" *)
module PCU(
    input clk,
    input rst,
    input [`ColorBUS] Color,
    input [  `DirBUS] Dir,
    input DRAW,
    //output reg [`PenBUS] Storex,
   // output reg [`PenBUS] Storey,
    //output reg [`ColorBUS] Storecol,
    ///output reg we,
    //output reg [`PenBUS] Penx,
    //output reg [`PenBUS] Peny,
    output [`ColorBUS] Colorout,
    output O_hs,
    output O_vs,
    /*,
    output Dirdelay,
    output cu,
    output cl,
    output cr,
    output cd,
    output Xcor,
    output Ycor,
    output Xflag*/
    output reg [7:0] an,
    output reg [6:0] seg
    );

    reg [`PenBUS] Xcor;
    reg [`PenBUS] Ycor;
    reg [`DirBUS] Dirdelay;
    
    reg [`PenBUS] Storex;
    reg [`PenBUS] Storey;
    reg [`ColorBUS] Storecol;
    reg we;
    reg [`PenBUS] Penx;
    reg [`PenBUS] Peny;
    
    reg [3:0] Q [7:0];
    reg [7:0] avail;
    
    
    reg Xflag;
    reg Shortmove;
    reg [31:0] cu;
    reg [31:0] cd;
    reg [31:0] cl;
    reg [31:0] cr;
    reg [13:0] lumove;
    reg [13:0] ldmove;
    reg [13:0] llmove;
    reg [13:0] lrmove;

    reg [3:0] Movex;
    
    always @(posedge clk or negedge rst)
    begin
        if (rst)
        begin
            Xcor <= 8'd128;
            Ycor <= 8'd128;
            Dirdelay <= 0;
            Shortmove <= 1;
            Xflag <= 0;
            cu <= 0;
            cd <= 0;
            cr <= 0;
            cl <= 0;
            ldmove <= 0;
            lumove <= 0;
            llmove <= 0;
            lrmove <= 0;
        end
        else
        begin
            if (Dir[0] && !Dirdelay[0]) // up appear
            begin
                cu <= 0;
                Shortmove <= 1;
                if (cd + cl + cr > 0)
                begin
                    Xflag <= 1;
                    if (cr > 0) Movex[0] <= 1;
                    else Movex[3] <= 1;
                end
            end
            
            if (Dir[0] && Dirdelay[0]) // up remain
            begin
                cu <= cu + 1;
                if (!Xflag && cu > 200000000)
                begin
                    Shortmove <= 0;
                    if ((cu - 200000000) % 100000000 == 0)
                    lumove <= lumove + 3;
                end
            end
            
            if (!Dir[0] && Dirdelay[0]) // up end
            begin
                if (Xflag)
                begin
                    if (cd + cl + cr == 0)
                    begin
                        if (Movex[0])
                        begin
                            Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
                            Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
                        end
                        else
                        begin
                            Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
                            Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        cu <= 0;
                        Movex <= 0;
                        Xflag <= 0;
                    end
                    else
                        cu <= 0;
                end
                else
                begin
                    cu <= 0;
                    if (Shortmove)
                        Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
                end
            end

            if (lumove > 0)
            begin
                lumove <= lumove - 1;
                Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
            end

            
            if (Dir[1] && !Dirdelay[1]) // right appear
            begin
                cr <= 0;
                Shortmove <= 1;
                if (cd + cl + cu > 0)
                begin
                    Xflag <= 1;
                    if (cu > 0) Movex[0] <= 1;
                    else Movex[1] <= 1;
                end
            end
            
            if (Dir[1] && Dirdelay[1]) // right remain
            begin
                cr <= cr + 1;
                if (!Xflag && cr > 200000000)
                begin
                    Shortmove <= 0;
                    if ((cr - 200000000) % 100000000 == 0)
                    lrmove <= lrmove + 3;
                end
            end
            
            if (!Dir[1] && Dirdelay[1]) // right end
            begin
                if (Xflag)
                begin
                    if (cd + cl + cu == 0)
                    begin
                        if (Movex[0])
                        begin
                            Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
                            Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
                        end
                        else
                        begin
                            Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
                            Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
                        end
                        cr <= 0;
                        Movex <= 0;
                        Xflag <= 0;
                    end
                    else
                        cr <= 0;
                end
                else
                begin
                    cr <= 0;
                    if (Shortmove)
                        Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
                end
            end

            if (lrmove > 0)
            begin
                lrmove <= lrmove - 1;
                Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
            end

            
            if (Dir[2] && !Dirdelay[2]) // down appear
            begin
                cd <= 0;
                Shortmove <= 1;
                if (cr + cl + cu > 0)
                begin
                    Xflag <= 1;
                    if (cd > 0) Movex[1] <= 1;
                    else Movex[2] <= 1;
                end
            end
            
            if (Dir[2] && Dirdelay[2]) // down remain
            begin
                cd <= cd + 1;
                if (!Xflag && cd > 200000000)
                begin
                    Shortmove <= 0;
                    if ((cd - 200000000) % 100000000 == 0)
                    ldmove <= ldmove + 3;
                end
            end
            
            if (!Dir[2] && Dirdelay[2]) // down end
            begin
                if (Xflag)
                begin
                    if (cr + cl + cu == 0)
                    begin
                        if (Movex[1])
                        begin
                            Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
                            Ycor <= (Ycor == 255 ? 255 : Ycor + 1);
                        end
                        else
                        begin
                            Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
                            Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        cd <= 0;
                        Movex <= 0;
                        Xflag <= 0;
                    end
                    else
                        cd <= 0;
                end
                else
                begin
                    cd <= 0;
                    if (Shortmove)
                        Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
                end
            end

            if (ldmove > 0)
            begin
                ldmove <= ldmove - 1;
                Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
            end
            
            if (Dir[3] && !Dirdelay[3]) // left appear
            begin
                cl <= 0;
                Shortmove <= 1;
                if (cr + cd + cu > 0)
                begin
                    Xflag <= 1;
                    if (cd > 0) Movex[2] <= 1;
                    else Movex[3] <= 1;
                end
            end
            
            if (Dir[3] && Dirdelay[3]) // left remain
            begin
                cl <= cl + 1;
                if (!Xflag && cl > 200000000)
                begin
                    Shortmove <= 0;
                    if ((cl - 200000000) % 100000000 == 0)
                    llmove <= llmove + 3;
                end
            end
            
            if (!Dir[3] && Dirdelay[3]) // left end
            begin
                if (Xflag)
                begin
                    if (cr + cd + cu == 0)
                    begin
                        if (Movex[2])
                        begin
                            Xcor <= (Xcor == 255 ? 255 : Xcor + 1);
                            Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        else
                        begin
                            Xcor <= (Xcor == 0 ? 0 : Xcor - 1);
                            Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        cl <= 0;
                        Movex <= 0;
                        Xflag <= 0;
                    end
                    else
                        cl <= 0;
                end
                else
                begin
                    cl <= 0;
                    if (Shortmove)
                        Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
                end
            end

            if (llmove > 0)
            begin
                llmove <= llmove - 1;
                Ycor <= (Ycor == 0 ? 0 : Ycor - 1);
            end

            Dirdelay <= Dir;
        end
    end
    
    always @*
    begin
        we   <= DRAW;
        Penx <= Xcor;
        Peny <= Ycor;
        Storecol <= Color;
        Storex <= Xcor;
        Storey <= Ycor;
    end

    reg [3:0] num;
    wire [6:0] seg0[7:0];
    reg [30:0] count;
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

    always @*
    begin
        avail <= 8'b01110111;
        
        Q[0] <= Ycor % 10;
        Q[1] <= Ycor / 10 % 10;
        Q[2] <= Ycor / 100;

        Q[4] <= Xcor % 10;
        Q[5] <= Xcor / 10 % 10;
        Q[6] <= Xcor / 100;
    end

    always@(posedge clk)
        if(count>=31'd19999)
        begin
            clk1<=~clk1;
            count=31'b0;
            num <= (num+1)%8;
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
        end
        1:begin
            an <=8'b11111101;
            seg<=seg0[1];
            if (!avail[1])
            seg<=7'b1111111;
        end
        2:begin
            an <=8'b11111011;
            seg<=seg0[2];
            if (!avail[2])
            seg<=7'b1111111;
        end
        3:begin
            an <=8'b11110111;
            seg<=seg0[3];
            if (!avail[3])
            seg<=7'b1111111;
        end
        4:begin
            an <=8'b11101111;
            seg<=seg0[4];
            if (!avail[4])
            seg<=7'b1111111;
        end
        5:begin
            an <=8'b11011111;
            seg<=seg0[5];
            if (!avail[5])
            seg<=7'b1111111;
        end
        6:begin
            an <=8'b10111111;
            seg<=seg0[6];
            if (!avail[6])
            seg<=7'b1111111;
        end
        7:begin
            an <=8'b01111111;
            seg<=seg0[7];
            if (!avail[7])
            seg<=7'b1111111;
        end
    endcase
    DCU  Screen (clk,rst,we,Penx,Peny,Storecol,O_hs,O_vs,Colorout);
endmodule
