`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:38 05/31/2018 
// Design Name: 
// Module Name:    InstrDef 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//--------------------¡¾OPÂë¡¿---------------------
//R-type
`define R_OP		6'b000000

//I-type
`define ADDI	   6'b001000
`define ADDIU		6'b001001
`define ANDI	   6'b001100
`define ORI	   	6'b001101
`define XORI		6'b001110
`define LUI			6'b001111
`define LW			6'b100011
`define SW			6'b101011
`define BEQ			6'b000100
`define BNE	   	6'b000101
`define BGEZ		6'b000001
`define BGTZ	   6'b000111
`define BLEZ   	6'b000110
`define BLTZ		6'b000001
`define SLTI		6'b001010
`define SLTIU		6'b001011

//J-type
`define J	   	6'b000010
`define JAL			6'b000011

//---------------------¡¾ALU²Ù×÷Âë¡¿------------------------
`define ALU_ADD  5'b00000;    
`define ALU_AND  5'b00001;    
`define ALU_XOR  5'b00010;   
`define ALU_OR   5'b00011;    
`define ALU_NOR  5'b00100;    
`define ALU_SUB  5'b00101;    
`define ALU_ANDI 5'b00110; 
`define ALU_XORI 5'b00111; 
`define ALU_ORI  5'b01000; 
`define ALU_JR   5'b01001; 
`define ALU_BEQ  5'b01010;    
`define ALU_BNE  5'b01011; 
`define ALU_BGEZ 5'b01100;    
`define ALU_BGTZ 5'b01101;   
`define ALU_BLEZ 5'b01110;    
`define ALU_BLTZ 5'b01111; 
`define ALU_SLL  5'b10000; 
`define ALU_SRL  5'b10001; 
`define ALU_SRA  5'b10010;  
`define ALU_SLT  5'b10011;    
`define ALU_SLTU 5'b10100; 
`define ALU_ADDU 5'b10101;
`define ALU_SUBU 5'b10110;



