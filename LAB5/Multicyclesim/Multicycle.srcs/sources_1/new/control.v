`include "define.v"
`timescale 1ns / 1ps

//* Controler
//* input with op
//* output control information

module control (input wire clk,
                input wire rst,
                input wire [`OP_BUS] op,            // * input the opcode part
                output reg pc_write_cond,           // * control pc
                output reg pc_write,                // * control pc
                output reg ins_or_data,             // * control mem
                output reg mem_read,                // * control mem
                output reg mem_write,               // * control mem
                output reg ir_write,                // * control ir
                output reg [1:0] pc_source,         // * control pc source
                output reg [1:0] alu_op,            // * control alu
                output reg alu_srca,                // * control numa
                output reg alu_srcb,                // * control numb
                output reg reg_write,               // * control regfile writable
                output reg regdst,
                output reg mem_to_reg,
                output reg [`STATE_BUS] state_out);
    
    reg [`STATE_BUS] state,next_state;
    
    initial begin
        state         = `IF_STATE;
        pc_write_cond = 0;
        pc_write      = 0;
        ins_or_data   = 0;
        mem_read      = 0;
        mem_write     = 0;
        ir_write      = 0;
        pc_source     = 0;
        alu_op        = 0;
        alu_srca      = 0;
        alu_srcb      = 0;
        reg_write     = 0;
        regdst        = 0;
    end
    
    always @*
    state_out = state;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= `IF_STATE;
            end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            `IF_STATE : next_state = `ID_STATE;
            `ID_STATE : begin
                case (op)
                    `OP_LW  : next_state = `EXE1_STATE;
                    `OP_SW  : next_state = `EXE1_STATE;
                    `OP_BEQ : next_state = `EXE3_STATE;
                    `OP_BNE : next_state = `EXE3_STATE;
                    `OP_J   : next_state = `EXE4_STATE;
                    default : next_state = `EXE2_STATE;
                endcase
            end
            `EXE1_STATE : begin
                if (op == `OP_LW)
                    next_state = `MEM1_STATE;
                else
                    next_state = `MEM2_STATE;
            end
            `EXE2_STATE : next_state = `WB2_STATE;
            `EXE3_STATE : next_state = `IF_STATE;
            `EXE4_STATE : next_state = `IF_STATE;
            `MEM1_STATE : next_state = `WB1_STATE;
            `MEM2_STATE : next_state = `IF_STATE;
            `WB1_STATE  : next_state = `IF_STATE;
            `WB2_STATE  : next_state = `IF_STATE;
        endcase
    end
    
    always @* begin
        // * if state == > initial state
        if (state == `IF_STATE) begin
            pc_write_cond = 0;
            pc_write      = 1; // * pc writable
            ins_or_data   = 0;
            mem_read      = 1; // * read mem for instructions
            mem_write     = 0;
            ir_write      = 1; // * ir writable
            pc_source     = 2'b00;
            alu_op        = 0;
            alu_srca      = 0;
            alu_srcb      = 0;
            reg_write     = 0;
            regdst        = 0;
        end
        
        // * id state
        if (state == `ID_STATE) begin
            pc_write = 0;
            ir_write = 0;
            mem_read = 0;
        end
        
        // * exe1 state
        if (state == `EXE1_STATE) begin
            alu_srca = 0;
            alu_srcb = 1;
            alu_op   = 2'b00;
        end
        
        // * exe2 state
        if (state == `EXE2_STATE) begin
            alu_srca = 0;
            alu_srcb = (op == `OP_R_TYPE ? 0 : 1);
            alu_op   = 2'b10;
        end
        
        // * exe3 state
        if (state == `EXE3_STATE) begin
            alu_srca      = 1;
            alu_srcb      = 0;
            alu_op        = 2'b01;
            pc_write      = 1;
            pc_write_cond = (op == `OP_BEQ ? 1 : 0);
            pc_source     = 2'b01;
        end
        
        // * exe4 state
        if (state == `EXE4_STATE) begin
            pc_write  = 1;
            pc_source = 2'b10;
        end
        
        // * mem1 state
        if (state == `MEM1_STATE) begin
            mem_read    = 1;
            ins_or_data = 1;
        end
        
        // * mem2 state
        if (state == `MEM2_STATE) begin
            mem_write   = 1;
            ins_or_data = 1;
        end
        
        // * wb1 state
        if (state == `WB1_STATE) begin
            regdst     = 0;
            reg_write  = 1;
            mem_to_reg = 1;
        end
        
        // * wb2 state
        if (state == `WB2_STATE) begin
            regdst     = (op == `OP_R_TYPE ? 1 : 0);
            reg_write  = 1;
            mem_to_reg = 0;
        end
    end
endmodule
