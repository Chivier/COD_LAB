`timescale 1ns / 1ps
`include "define.v"

module ddu(input cont,
           input rst,
           input clk_board,
           input step,
           input mem,
           input inc,
           input dec,
           output reg [7:0] addrout_8,
           output wire [7:0] pc_8,
           output pc_write,
           output wire [`STATE_BUS] state,
           output wire [`REG_BUS] irrun,
           output wire [6:0] seg,
           output wire [7:0] an,
           output wire [1023:0] reg_clone,
           output [`REG_BUS] numa,
           output [`REG_BUS] numb,
           output wire [`REG_BUS] memshow);

    wire [`REG_BUS] memshow;
    reg [`REG_BUS] addrout;
    wire [`REG_BUS] pc;

    reg [`REG_BUS] addr = 0;
    wire [`REG_BUS] mem1;
    wire [`REG_BUS] mem2;
    reg clk;
    reg delay;
    reg incdelay;
    reg decdelay;

    always @(posedge clk_board or negedge rst)
    begin
        if (rst) begin
            addr <= 0;
            incdelay = 1;
            decdelay = 1;
            delay    = 0;
            end else begin

            if (!incdelay && inc) addr = addr + 1;
            if (!decdelay && dec) addr = addr - 1;

            incdelay = inc;
            decdelay = dec;

            addrout                 = addr;
            if (!delay && step) clk = 1;
            else clk                = 0;

            delay = step;

        end
    end
    assign memshow = mem ? mem1 : mem2;

    cpu CPU_sim (.clk (clk), .rst (rst), .pcout (pc), .inputaddr(addr) , .memout_show (mem1),.regout_show(mem2) , .regshow(reg_clone)
    ,.state(state) , .numatest(numa) , .numbtest(numb), .pc_write(pc_write) ,.irrun (irrun));

    always @* addrout_8 = {addr [7:0]};

    assign pc_8 = {pc[9:2]};

    segout segmental (.clk (clk_board), .indata (memshow), .an(an) ,.seg(seg));
endmodule
