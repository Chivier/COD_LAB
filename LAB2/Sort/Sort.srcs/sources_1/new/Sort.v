`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 22:14:02
// Design Name: 
// Module Name: Sort
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


module Sort(
    input rst,
    input [3:0] sIN1,
    input [3:0] sIN2,
    input [3:0] sIN3,
    input [3:0] sIN4,
    output reg [3:0] sOUT1,
    output reg [3:0] sOUT2,
    output reg [3:0] sOUT3,
    output reg [3:0] sOUT4
    );
    
    wire T12,T13,T14,T23,T24,T34;
    
    reg [3:0] TMP;
    reg [3:0] tOUT1,tOUT2,tOUT3,tOUT4;
    
    always@*
    begin
            sOUT1=tOUT1;
            sOUT2=tOUT2;
            sOUT3=tOUT3;
            sOUT4=tOUT4;
    end
    
    always @*
    begin
        if (rst)
        begin
                    tOUT1 = sIN1;
                    tOUT2 = sIN2;
                    tOUT3 = sIN3;
                    tOUT4 = sIN4;
        end
        else
        begin
        if (T12) begin TMP = tOUT1; tOUT1 = tOUT2; tOUT2 = TMP; end
        if (T13) begin TMP = tOUT1; tOUT1 = tOUT3; tOUT3 = TMP; end
        if (T14) begin TMP = tOUT1; tOUT1 = tOUT4; tOUT4 = TMP; end
        if (T23) begin TMP = tOUT2; tOUT2 = tOUT3; tOUT3 = TMP; end
        if (T24) begin TMP = tOUT2; tOUT2 = tOUT4; tOUT4 = TMP; end
        if (T34) begin TMP = tOUT3; tOUT3 = tOUT4; tOUT4 = TMP; end
        end
    end
    
        CMP c12(tOUT1,tOUT2,T12);
        CMP c13(tOUT1,tOUT3,T13);
        CMP c14(tOUT1,tOUT4,T14);
        CMP c23(tOUT2,tOUT3,T23);
        CMP c24(tOUT2,tOUT4,T24);
        CMP c34(tOUT3,tOUT4,T34);
endmodule
