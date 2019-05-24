`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 23:56:50
// Design Name: 
// Module Name: DIV
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
`include "DEFINE.v"

module DIV(
    input clk,
    input rst,
    input [`OPERAND_BUS] A,
    input [`OPERAND_BUS] B,
    output [`OPERAND_BUS] C,
    output [`OPERAND_BUS] D
);

    reg [`OPERAND_BUS]q;
    reg [`OPERAND_BUS]r;
    reg [`OPERAND_BUS]t;
    
    integer i;
    
    always@(posedge clk or negedge rst)
    begin
    if(!rst)
    begin
        q=0;
        r=0;
    end
    else
    begin
        q=A;
        t={4'b0000,B};
        r=8'b00000000;
        {r,q}={r,q}<<1;
    
        for(i=0;i<8;i=i+1)
        if(r>=t)
        begin
            r=r-t;
            {r,q}={r,q}<<1;
            q[0]=1;
        end
        else
        begin
            r=r;
            {r,q}={r,q}<<1;
            q[0]=0;
        end
    end
    end
    assign C=q;
    assign D=r>>1;
endmodule
