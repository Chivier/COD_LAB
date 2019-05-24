`include "define.v"
`timescale 1ns / 1ps

module regfile(input wire clk,
               input wire [`RS_BUS] rs,
               input wire [`RT_BUS] rt,
               input wire [`RD_BUS] rd,
               input wire reg_write,
               input wire regdst,
               input wire [`REG_BUS] indata,
               output reg [`REG_BUS] numa,
               output reg [`REG_BUS] numb,
               input wire [`REG_BUS] regaddr,
               output reg [`REG_BUS] reg_out,
               output reg [1023:0] reg_clone);
    
    reg [`REG_BUS] register [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32 ; i = i + 1) begin
            register[i] = 0;
        end
    end
    
    always @* begin
        reg_clone = 0;
        for (i = 31; i > = 0 ; i = i - 1) begin
            reg_clone = (reg_clone << 32)  | register[i];
        end
    end
    
    always @(posedge clk) begin
        if (reg_write) begin
            if (regdst) begin
                register[rd] = indata;
                end else begin
                register[rt] = indata;
            end
        end
        
        numa = register [rs];
        numb = register [rt];
    end
    always@* reg_out = register [(regaddr % 31)];
endmodule
