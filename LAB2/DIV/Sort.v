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
    input [3:0] IN1,
    input [3:0] IN2,
    input [3:0] IN3,
    input [3:0] IN4,
    output reg [3:0] OUT1,
    output reg [3:0] OUT2,
    output reg [3:0] OUT3,
    output reg [3:0] OUT4
    );
    
    wire T12,T13,T14,T23,T24,T34;
    
    reg [3:0] TMP;
    reg [3:0] tOUT1,tOUT2,tOUT3,tOUT4;
    
    always@*
    begin
            tOUT1 = IN1;
            tOUT2 = IN2;
            tOUT3 = IN3;
            tOUT4 = IN4;
    end
    
    always@*
    begin
        OUT1=tOUT1;
        OUT2=tOUT2;
        OUT3=tOUT3;
        OUT4=tOUT4;
    end
    
    always @*
    begin
        if (T12) begin TMP = OUT1; OUT1 = OUT2; OUT2 = TMP; end
        if (T13) begin TMP = OUT1; OUT1 = OUT3; OUT3 = TMP; end
        if (T14) begin TMP = OUT1; OUT1 = OUT4; OUT4 = TMP; end
        if (T23) begin TMP = OUT2; OUT2 = OUT3; OUT3 = TMP; end
        if (T24) begin TMP = OUT2; OUT2 = OUT4; OUT4 = TMP; end
        if (T34) begin TMP = OUT3; OUT3 = OUT4; OUT4 = TMP; end
    end
    
        CMP c12(OUT1,OUT2,T12);
        CMP c13(OUT1,OUT3,T13);
        CMP c14(OUT1,OUT4,T14);
        CMP c23(OUT2,OUT3,T23);
        CMP c24(OUT2,OUT4,T24);
        CMP c34(OUT3,OUT4,T34);
endmodule
