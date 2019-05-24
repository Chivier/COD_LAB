    `timescale 1ns / 1ps
    
    `include "DEFINE.v"
    
    module ALU_tb (
        );
        
       reg CLOCK_50;
       reg rst;
    
        reg  [`OPECODE_BUS] OP;
        reg  [`OPERAND_BUS] A;
        reg  [`OPERAND_BUS] B;
        wire  [`OPERAND_BUS] C;
        wire  [`OPECODE_BUS] F;
    
       initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
       end
       
       initial begin
        rst = 0;
        #100 rst = 1;
        #10  rst = 0;
        #20 OP = `EXE_ORI; A = 6'b01000; B = 6'b00111;
        #20 OP = `EXE_AND; A = 6'b01000; B = 6'b00111;
        #20 OP = `EXE_ADD; A = 6'b01000; B = 6'b111111;
        #20 OP = `EXE_ADD; A = 6'b000000; B = 6'b000000;
        #20 OP = `EXE_SUB; A = 6'b01000; B = 6'b110111; 
        #20 $stop;
       end
       
       ALU aluer(
        .clk(CLOCK_50),
        .rst(rst),
        .OP(OP),
        .A(A),
        .B(B),
        .C(C),
        .F(F)
       );
    endmodule