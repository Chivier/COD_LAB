`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:23:26 06/05/2018
// Design Name:   ZeroTest
// Module Name:   E:/DownLoad/COD_lab7/CPU.v
// Project Name:  COD_lab7
// Target Device:  
// Tool versions:  
// Description: 
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module CPUdl(
   input clk,
	input switch_en,
	input seq_en,
	input [4:0] switch_addr,
	output [15:0]data
	);
	


///////////////////////////////////��IF��////////////////////////////////////////
  wire [31:0]NextPC_if,BranchAddress,JumpAddress,RsData_id;
  reg [31:0]PC_in;
  wire Z,J,JR;
  wire RegWrite_ex;
  wire [4:0]RegWriteAddr_ex,RsAddr_id;
  wire [31:0]ALUResult_ex;
  wire [31:0]JrAddr;
  wire forward_jr;
  assign forward_jr=RegWrite_ex&&(RegWriteAddr_ex==RsAddr_id);
  assign JrAddr=forward_jr ? ALUResult_ex : RsData_id;
  
  //MUX
  always@(*)       
	begin         
		case({JR,J,Z})           
		3'b000:PC_in<=NextPC_if;           
		3'b001:PC_in<=BranchAddress;           
		3'b010:PC_in<=JumpAddress;           
		3'b100:PC_in<=JrAddr; 
		default:PC_in<=32'b0;
		endcase       
	end   

  //PC
  wire [31:0]PC;
  assign NextPC_if=PC+4;
  wire PC_IFWrite;
  Reg	#(.width(32))PC_reg_if(.clk(clk),.reset(1'b0),.enable(PC_IFWrite),.in(PC_in),.out(PC));

  
  //InstructionRom
  wire [31:0]Instruction_if;
  InstructionROMDl InstrUnit(.addr(PC),.dout(Instruction_if));
  
  //FLUSH
  wire IF_flush;
  assign IF_flush=JR||J||Z;


//---------------------------��IF/ID��--------------------------------------------------------------------------------------
wire [31:0]NextPC_id;
wire [31:0]Instruction_id;
Reg	#(.width(32))PC_if_id(.clk(clk),.reset(IF_flush),.enable(PC_IFWrite),.in(NextPC_if),.out(NextPC_id));
Reg	#(.width(32))Instr_if_id(.clk(clk),.reset(IF_flush),.enable(PC_IFWrite),.in(Instruction_if),.out(Instruction_id));
//--------------------------------------------------------------------------------------------------------------------------

////////////////////////////////��ID��////////////////////////////////////

//ָ������
wire MemtoReg_id,RegWrite_id,MemWrite_id,MemRead_id,ALUSrcA_id,ALUSrcB_id,RegDst_id,Branch_id;
wire [1:0]LwByte_id;
wire [4:0]ALUCode_id;
Decode decoder(.Instruction(Instruction_id),.MemtoReg(MemtoReg_id),.RegWrite(RegWrite_id),.MemWrite(MemWrite_id),.MemRead(MemRead_id),.ALUCode(ALUCode_id),
				.ALUSrcA(ALUSrcA_id),.ALUSrcB(ALUSrcB_id),.RegDst(RegDst_id),.J(J),.JR(JR),.Branch(Branch_id),.LwByte(LwByte_id));

wire   [4:0]RtAddr_id,RdAddr_id;
assign RsAddr_id=Instruction_id[25:21];
assign RtAddr_id=Instruction_id[20:16];
assign RdAddr_id=Instruction_id[15:11];

//λ��չ
wire [31:0]Imm_id,Sa_id;
assign Imm_id={{16{Instruction_id[15]}},Instruction_id[15:0]}; 
assign Sa_id ={27'b0,Instruction_id[10:6]}; 				
				
//��֧��ת��ַ����				
assign BranchAddress=NextPC_id+(Imm_id<<2);
assign JumpAddress={NextPC_id[31:28],Instruction_id[25:0],2'b00}; 

//��֧���
wire [31:0]RtData_id;
wire forward_zero_Rs,forward_zero_Rt;
assign forward_zero_Rs=RegWrite_ex&&(RegWriteAddr_ex==RsAddr_id);
assign forward_zero_Rt=RegWrite_ex&&(RegWriteAddr_ex==RsAddr_id);
wire [31:0]RsData_zero,RtData_zero;
assign RsData_zero=forward_zero_Rs ? ALUResult_ex : RsData_id;
assign RtData_zero=forward_zero_Rt ? ALUResult_ex : RtData_id;
ZeroTest zero_unit(.ALUCode(ALUCode_id),.RsData(RsData_zero),.RtData(RtData_zero),.Z(Z));
	
//ð�ռ��
wire MemRead_ex;
wire Stall;
HazardDetector hazard_unit(.RegWriteAddr(RegWriteAddr_ex),.MemRead(MemRead_ex),.RsAddr(RsAddr_id),.RtAddr(RtAddr_id),.Stall(Stall),.PC_IFWrite(PC_IFWrite));

//�Ĵ�����
wire RegWrite_wb;
wire [4:0]RegWriteAddr_wb;
wire [31:0]RegWriteData_wb;
wire [31:0]RsData_temp,RtData_temp;
Registers register_unit(.clk(clk),.RsAddr(RsAddr_id),.RtAddr(RtAddr_id),.WriteData(RegWriteData_wb),.WriteAddr(RegWriteAddr_wb),.RegWrite(RegWrite_wb),
						.RsData(RsData_temp),.RtData(RtData_temp));	

//����ת������
wire RsSel,RtSel;						
assign RsSel=RegWrite_wb&&(~(RegWriteAddr_wb==0))&&(RegWriteAddr_wb==RsAddr_id);   
assign RtSel=RegWrite_wb&&(~(RegWriteAddr_wb==0))&&(RegWriteAddr_wb==RtAddr_id); 
assign	RsData_id=(RsSel==1)? RegWriteData_wb : RsData_temp;
assign 	RtData_id=(RtSel==1)? RegWriteData_wb : RtData_temp;		
				
//----------------------------------��ID/EX��----------------------------------------------
wire MemtoReg_ex,MemWrite_ex,RegDst_ex,ALUSrcA_ex,ALUSrcB_ex;
wire [1:0]LwByte_ex;
wire [4:0]ALUCode_ex;
wire [31:0]Sa_ex,Imm_ex,RsData_ex,RtData_ex;
wire [4:0]RdAddr_ex,RtAddr_ex,RsAddr_ex;

Reg	#(.width(2))LwByte_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(LwByte_id),.out(LwByte_ex));
Reg	#(.width(2))WB_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in({MemtoReg_id,RegWrite_id}),.out({MemtoReg_ex,RegWrite_ex}));
Reg	#(.width(2))M_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in({MemWrite_id,MemRead_id}),.out({MemWrite_ex,MemRead_ex}));
Reg	#(.width(3))EX_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in({RegDst_id,ALUSrcA_id,ALUSrcB_id}),.out({RegDst_ex,ALUSrcA_ex,ALUSrcB_ex}));
Reg	#(.width(5))ALUCode_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(ALUCode_id),.out(ALUCode_ex));
Reg	#(.width(32))Sa_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(Sa_id),.out(Sa_ex));
Reg	#(.width(32))Imm_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(Imm_id),.out(Imm_ex));
Reg	#(.width(5))RdAddr_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(RdAddr_id),.out(RdAddr_ex));
Reg	#(.width(5))RsAddr_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(RsAddr_id),.out(RsAddr_ex));
Reg	#(.width(5))RtAddr_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(RtAddr_id),.out(RtAddr_ex));
Reg	#(.width(32))RsData_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(RsData_id),.out(RsData_ex));
Reg	#(.width(32))RtData_id_ex(.clk(clk),.reset(Stall),.enable(1'b1),.in(RtData_id),.out(RtData_ex));
//--------------------------------------------------------------------------------------------------------

////////////////////////////////��EX��//////////////////////////////////////////////////
wire [31:0]ALUResult_mem;
wire [1:0]ForwardA,ForwardB;
wire [4:0]RegWriteAddr_mem;
wire RegWrite_mem;

//Forwarding
Forwarding forward_unit(.RegWrite_wb(RegWrite_wb),.RegWrite_mem(RegWrite_mem),.RegWriteAddr_wb(RegWriteAddr_wb),.RegWriteAddr_mem(RegWriteAddr_mem),
						.RsAddr_ex(RsAddr_ex),.RtAddr_ex(RtAddr_ex),.ForwardA(ForwardA),.ForwardB(ForwardB));

//MUX
wire [31:0]ALUSrcA_d_in,ALUSrcA_d,ALUSrcB_d,MemWriteData_ex;
Mux4 #(.width(32))ALUSrcA_mux4(.sel(ForwardA),.in0(RsData_ex),.in1(RegWriteData_wb),.in2(ALUResult_mem),.in3(0),.out(ALUSrcA_d_in));
assign ALUSrcA_d=(ALUSrcA_ex==1)? Sa_ex : ALUSrcA_d_in;
Mux4 #(.width(32))ALUSrcB_mux4(.sel(ForwardB),.in0(RtData_ex),.in1(RegWriteData_wb),.in2(ALUResult_mem),.in3(0),.out(MemWriteData_ex));
assign ALUSrcB_d=(ALUSrcB_ex==1)? Imm_ex : MemWriteData_ex;

assign RegWriteAddr_ex=(RegDst_ex==1)? RdAddr_ex : RtAddr_ex;

//ALU
ALU ALU_unit(.ALUCode(ALUCode_ex),.A(ALUSrcA_d),.B(ALUSrcB_d),.Result(ALUResult_ex));


//----------------------------------��Ex/MEM��-------------------------------------------------------- 
wire MemtoReg_mem,MemWrite_mem;
wire [31:0]MemWriteData_mem;
wire [1:0]LwByte_mem;

Reg	#(.width(2))LwByte_ex_mem(.clk(clk),.reset(1'b0),.enable(1'b1),.in(LwByte_ex),.out(LwByte_mem));
Reg	#(.width(3))Signal_ex_mem(.clk(clk),.reset(1'b0),.enable(1'b1),.in({MemtoReg_ex,RegWrite_ex,MemWrite_ex}),.out({MemtoReg_mem,RegWrite_mem,MemWrite_mem}));
Reg	#(.width(32))ALUResult_ex_mem(.clk(clk),.reset(1'b0),.enable(1'b1),.in(ALUResult_ex),.out(ALUResult_mem));
Reg	#(.width(32))MemWriteData_ex_mem(.clk(clk),.reset(1'b0),.enable(1'b1),.in(MemWriteData_ex),.out(MemWriteData_mem));
Reg	#(.width(5))RegWriteAddr_ex_mem(.clk(clk),.reset(1'b0),.enable(1'b1),.in(RegWriteAddr_ex),.out(RegWriteAddr_mem));
//-----------------------------------------------------------------------------------------------------------------------

//////////////////////////////////////��MEM��///////////////////////////////////////////////////////////////////////////////////////////////

//DataRam

wire [31:0]RamOut_mem;
wire [4:0] seq_addr;

Sequence seq_unit(clk,seq_en,seq_addr);

wire [31:0]Ram_Addr;
assign Ram_Addr= seq_en ? {25'b0,seq_addr,2'b00} : (switch_en ? {25'b0,switch_addr,2'b00} : ALUResult_mem);
DataRamDl data_unit(.clk(clk),.addr(Ram_Addr),.din(MemWriteData_mem),.we(MemWrite_mem),.dout(RamOut_mem));

//DataRam data_unit(.clk(clk),.addr(ALUResult_mem),.din(MemWriteData_mem),.we(MemWrite_mem),.dout(RamOut_mem));
//DataRam data_unit(.clk(clk),.addr(ALUResult_mem),.LwByte(LwByte_mem),.din(MemWriteData_mem),.we(MemWrite_mem),.dout(RamOut_mem));




//----------------------------------��MEM/WB��---------------------------------------------------------------------------------------- 
wire MemtoReg_wb;
wire [31:0]ALUResult_wb;
wire [31:0]RamOut_wb;
Reg	#(.width(2))WB_mem_ex(.clk(clk),.reset(1'b0),.enable(1'b1),.in({RegWrite_mem,MemtoReg_mem}),.out({RegWrite_wb,MemtoReg_wb}));
Reg	#(.width(32))ALUResult_mem_wb(.clk(clk),.reset(1'b0),.enable(1'b1),.in(ALUResult_mem),.out(ALUResult_wb));
Reg	#(.width(5))RegWriteAddr_mem_wb(.clk(clk),.reset(1'b0),.enable(1'b1),.in(RegWriteAddr_mem),.out(RegWriteAddr_wb));
Reg	#(.width(32))RamOut_mem_wb(.clk(clk),.reset(1'b0),.enable(1'b1),.in(RamOut_mem),.out(RamOut_wb));
//-----------------------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////��WB��/////////////////////////////////////////////////////////////////////////////////

assign RegWriteData_wb=(MemtoReg_wb==1)? RamOut_wb : ALUResult_wb;
assign data=RamOut_mem[15:0];

endmodule