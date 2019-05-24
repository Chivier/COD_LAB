`include "define.v"
`timescale 1ns / 1ps

module cpu (input wire clk,
            input wire rst,
            output [`REG_BUS] pcout,
            input [`REG_BUS] inputaddr,
            output [`REG_BUS] memout_show,
            output [`REG_BUS] regout_show);
    // * ir split
    wire [`NUM1_BUS] num1;
    wire [`NUM2_BUS] num2;
    wire [`NUM3_BUS] num3;
    wire [`NUM4_BUS] num4;
    wire [`NUM5_BUS] num5;
    wire [`NUM6_BUS] num6;
    
    wire [`REG_BUS] jext;
    wire [`REG_BUS] aluout;
    wire [`REG_BUS] numa;
    wire [`REG_BUS] numb;
    wire [`REG_BUS] alu_numa;
    wire [`REG_BUS] alu_numb;
    wire [`REG_BUS] memaddr;
    wire [`REG_BUS] memmdr;
    wire [`REG_BUS] regmem;
    wire [`REG_BUS] immext;
    wire [`REG_BUS] memdata;
    
    wire [`EXE_BUS] aluexe;
    wire [`OP_BUS] opcode;
    
    // * control wire
    wire ins_or_data;
    wire pc_write_cond;
    wire pc_write;
    wire alu_srca;
    wire alu_srcb;
    wire ir_write;
    wire mem_write;
    wire mem_read;
    wire is_zero;
    wire mem_to_reg;
    wire reg_write;
    wire regdst;
    wire [1:0] pc_source;
    wire [1:0] alu_op;
    
    opj_extend jexter (
    .ins (num5),
    .pc (pcout),
    .extd (jext));
    
    pc_reg pc (
    .clk (clk),
    .rst (rst),
    .pccond (pc_write_cond),
    .pcsource (pc_source),
    .aluinfo(is_zero),
    .pc_write(pc_write),
    .immpc (num3),
    .address(jext),
    .pcout (pcout));
    
    // * A little change here
    // * address must divide by 4 here --> real addr in mem
    
    // * get the address
    mux2 mux_ins_or_data (
    .select (ins_or_data),
    .route1 (aluout >> 2),
    .route2 (pcout >> 2),
    .outdata (memaddr));
    
    // * memory
    mem memory (
    .clk(clk),
    .memwrite (mem_write),
    .indata (numb),
    .addr (memaddr),
    .memdata (memdata),
    .dpra (inputaddr),
    .dpo (memout_show));
    
    // * ir
    ins_split ir (
    .ir_write (ir_write),
    .ins (memdata),
    .opcode (opcode),
    .num1 (num1),
    .num2 (num2),
    .num3 (num3),
    .num4 (num4),
    .num5 (num5),
    .num6(num6),
    .irrun (irrun));
    
    // * mdr
    mdr memory_data_reg (
    .memread (mem_read),
    .memdata (memdata),
    .memout (memmdr));
    
    // * control
    control ctrl (
    .clk (clk),
    .rst (rst),
    .op (opcode),
    .pc_write_cond (pc_write_cond),
    .pc_write (pc_write),
    .ins_or_data (ins_or_data),
    .mem_read(mem_read),
    .mem_write (mem_write),
    .ir_write(ir_write),
    .pc_source(pc_source),
    .alu_op (alu_op),
    .alu_srca (alu_srca),
    .alu_srcb (alu_srcb),
    .reg_write (reg_write),
    .regdst (regdst),
    .mem_to_reg (mem_to_reg));
    
    // * reg write
    mux2 reg_write_mem (
    .select (mem_to_reg),
    .route1(memmdr),
    .route2(aluout),
    .outdata (regmem));
    
    // * reg
    regfile regs (
    .clk (clk),
    .rs (num1),
    .rt (num2),
    .rd (num4),
    .numa (numa),
    .numb (numb),
    .reg_write (reg_write),
    .regdst (regdst),
    .indata (regmem),
    .regaddr (inputaddr),
    .reg_out(regout_show));
    
    // * mux for numa
    mux2 muxnuma (
    .select (alu_srca),
    .route1 (pcout),
    .route2 (numa) ,
    .outdata (alu_numa));
    
    // * extend immediate num
    extend extder (
    .ins (num3),
    .extd (immext));
    
    // * mux for numb
    mux2 muxnumb (
    .select (alu_srcb),
    .route1 (immext),
    .route2(numb),
    .outdata (alu_numb));
    
    // * translate alu info
    alu_ctrl aluexe_maker (
    .opcode (opcode),
    .funt (num6),
    .alu_op (aluexe));
    
    // * alu
    alu alucalc (
    .aluop (aluexe),
    .numa (alu_numa),
    .numb(alu_numb),
    .num_out (aluout),
    .iszero (is_zero));
endmodule
