`timescale 1ns / 1ps
`include "define.v"

module ddu(input cont,
           input rst,
           input clk_board100,
           input step,
           input mem,
           input inc,
           input dec,
           output reg [7:0] addrout_8,
           output wire [7:0] pc_8,
           output wire [6:0] seg,
           output wire [7:0] an);

    wire clk_boardtmp;

    // * translate 100Mhz
    clk_wiz_0 (.clk_in1(clk_board100),.clk_out1(clk_boardtmp));

    wire [`REG_BUS] memshow;
    reg [`REG_BUS] addrout;
    wire [`REG_BUS] pc;
    reg clk_board = 0;
    reg [14:0] cnt;

    // * slow clock
    always @(posedge clk_boardtmp) begin
        if (cnt > = 15'd100) begin
            cnt       = 0;
            clk_board = ~clk_board;
        end
        else
            cnt = cnt + 1;
    end

    reg [`REG_BUS] addr = 0;
    wire [`REG_BUS] mem1;
    wire [`REG_BUS] mem2;
    reg clkt;
    reg delay;
    reg incdelay;
    reg decdelay;
    wire clk;

    always @(posedge clk_board or negedge rst)
    begin
        if (rst) begin
            addr <= 0;
            incdelay = 1;
            decdelay = 1;
            delay    = 0;
        end
        else
        begin
            // * control addr
            if (!incdelay && inc) addr = addr + 1;
            if (!decdelay && dec) addr = addr - 1;

            incdelay = inc;
            decdelay = dec;

            addrout = addr;

            // * generate only one pulse
            if (!delay && step)
                clkt = 1;
            else
                clkt = 0;

            delay = step;
        end
    end

    assign memshow = mem ? mem1 : mem2;
    assign clk     = cont ? clk_board : clkt;

    // * cpu
    cpu CPU_sim (.clk (clk), .rst (rst), .pcout (pc), .inputaddr(addr) , .memout_show (mem1), .regout_show(mem2));

    always @* addrout_8 = {addr [7:0]};
    assign pc_8         = {pc[9:2]};

    // * segout
    segout segmental (.clk (clk_board), .indata (memshow), .an(an) ,.seg(seg));
endmodule