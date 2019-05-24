`timescale 1ns / 1ps

`define ColorBUS 11:0
`define DirBUS   3:0
`define PenBUS   7:0

module VRAM(
        input [`PenBUS] Xcor,
        input [`PenBUS] Ycor,
        input [`ColorBUS] Color,
        input we,
        input clk,
        input [`PenBUS] Xreq,
        input [`PenBUS] Yreq,
        output [`ColorBUS] Colout
    );
    
    wire [15:0] address;
    assign address = {Xcor,Ycor};
    wire [15:0] reqadd;
    assign reqadd = {Xreq,Yreq};
    dist_mem_gen_0 St (.a(address),.d(Color),.dpra(reqadd),.clk(clk),.we(we),.dpo(Colout));
endmodule
