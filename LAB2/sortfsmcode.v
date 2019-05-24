`timescale 1ns / 1ps

module Sort(
    input rst,
    input clk,
    input [3:0] sIN1,
    input [3:0] sIN2,
    input [3:0] sIN3,
    input [3:0] sIN4,
    output [7:0] an,
    output [7:0] seg
    );

    wire T12,T13,T14,T23,T24,T34;
    reg [3:0] TMP;
    reg [3:0] tOUT1,tOUT2,tOUT3,tOUT4;
    reg [3:0] nOUT1,nOUT2,nOUT3,nOUT4;
    reg [3:0] sOUT1,sOUT2,sOUT3,sOUT4;
    reg jud;

    always @(posedge clk or negedge rst)
    begin
        if (rst)
        begin
            nOUT1 = sIN1;
            nOUT2 = sIN2;
            nOUT3 = sIN3;
            nOUT4 = sIN4;
        end
        else
        begin
            jud = 0;
            nOUT1 = tOUT1;
            nOUT2 = tOUT2;
            nOUT3 = tOUT3;
            nOUT4 = tOUT4;
        end
    end

    CMP c12(nOUT1,nOUT2,T12);
    CMP c23(nOUT2,nOUT3,T23);
    CMP c34(nOUT3,nOUT4,T34);

    always @*
    begin
        if (jud)
        begin
        if (T12) begin TMP = nOUT1; nOUT1 = nOUT2; nOUT2 = TMP; jud=1; end
        if (T23) begin TMP = nOUT2; nOUT2 = nOUT3; nOUT3 = TMP; jud=1; end
        if (T34) begin TMP = nOUT3; nOUT3 = nOUT4; nOUT4 = TMP; jud=1; end
        end
    end

    always @(posedge clk or negedge rst)
    begin
        tOUT1 = nOUT1;
        tOUT2 = nOUT2;
        tOUT3 = nOUT3;
        tOUT4 = nOUT4;
        if (!jud)
        begin
            sOUT1 = tOUT1;
            sOUT2 = tOUT2;
            sOUT3 = tOUT3;
            sOUT4 = tOUT4;
            SegOUT (clk,sOUT1,sOUT2,sOUT3,sOUT4,an,seg);
        end
    end
endodule
