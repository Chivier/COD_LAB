`include "define.v"
`timescale 1ns / 1ps

//* 00. normal
//*     PC = PC + 4
//* 01. special case 1 - bne & beq
//*     PC = immpc + 4
//* 10. special case 2 - j
//*     PC = jump address

module pc_reg (input wire clk,
               input wire rst,                // * clk & reset
               input wire pccond,
               input wire aluinfo,
               input wire pc_write,
               input wire [1:0] pcsource,
               input wire [`NUM3_BUS] immpc,
               input wire [`REG_BUS] address,
               output reg [`REG_BUS] pcout);
    
    reg [`REG_BUS] pc;
    
    initial        begin
        pc = 0;
    end
    
    always @(posedge clk or posedge rst) begin
        pcout = pc;
        if (rst) begin
            pc <= 0;
        end
        else
        begin
            if (pc_write) begin
                case (pcsource)
                    2'b00: pc <= pc + 4;
                    2'b01:
                    begin
                        // * 2 cases: pccond = 1 (beq) & iszero (from cmp = 1) = 0
                        // *      or  pccond = 0 (bne) & iszero (from cmp = 0) = 1
                        if (pccond ^ aluinfo)
                            pc <= pc;
                        else
                            pc <= pc + (immpc << 2);
                    end
                    2'b10:   pc <= address;
                    default: pc <= pc;
                endcase
            end
        end
        
        
    end
endmodule
