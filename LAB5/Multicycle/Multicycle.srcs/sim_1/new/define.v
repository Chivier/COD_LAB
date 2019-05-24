//* r_type
//* begin with 000000
`define OP_R_TYPE 6'b000000
`define FUNC_ADDU 6'b100001
`define FUNC_ADD  6'b100000 //* do
`define FUNC_SUB  6'b100010 //* do
`define FUNC_SUBU 6'b100011
`define FUNC_AND  6'b100100 //* do
`define FUNC_OR   6'b100101 //* do
`define FUNC_XOR  6'b100110 //* do
`define FUNC_NOR  6'b100111 //* do
`define FUNC_SLT  6'b101010 //* do
`define FUNC_SLTU 6'b101011
`define FUNC_SLL  6'b000000 //* do
`define FUNC_SRL  6'b000010 //* do
`define FUNC_SRA  6'b000011
`define FUNC_SLLV 6'b000100
`define FUNC_SRLV 6'b000110
`define FUNC_SRAV 6'b000111
`define FUNC_JR   6'b001000

//* i_type
`define OP_ADDI   6'b001000 //* do
`define OP_ANDI   6'b001100 //* do
`define OP_ORI    6'b001101 //* do
`define OP_XORI   6'b001110 //* do
`define OP_LUI    6'b001111
`define OP_LW     6'b100011 //* do
`define OP_SW     6'b101011 //* do
`define OP_BEQ    6'b000100 //* do
`define OP_BNE    6'b000101 //* do
`define OP_SLTI   6'b001010 //* do
`define OP_SLTIU  6'b001101

//* j_type
`define OP_J      6'b000100 //* do
`define OP_JAL    6'b000011

//* exe will be used
`define EXE_ADD   4'b0000
`define EXE_SUB   4'b0001
`define EXE_CMP   4'b0010
`define EXE_SLT   4'b0011
`define EXE_NOR   4'b0100
`define EXE_OR    4'b0101
`define EXE_AND   4'b0110
`define EXE_XOR   4'b0111
`define EXE_NOP   4'b1111

//* bus_information
`define PCCTRL_BUS 1:0
`define STATE_BUS  3:0
`define EXE_BUS    3:0
`define RS_BUS     4:0
`define RT_BUS     4:0
`define RD_BUS     4:0
`define SHAMT_BUS  4:0
`define STALL_BUS  5:0
`define OP_BUS     5:0
`define FUNT_BUS   5:0
`define ADDR_BUS   7:0
`define DATA_BUS   31:0
`define REG_BUS    31:0

`define OPCODE_BUS   31:26
`define NUM1_BUS     25:21
`define NUM2_BUS     20:16
`define NUM3_BUS     15:0
`define NUM4_BUS     15:11
`define NUM5_BUS     25:0
`define NUM6_BUS     5:0
`define FUNTCODE_BUS 5:0

`define REG_VEC    0:31
`define MEM_VEC    0:255

//* control tags
`define INS_TAG    0
`define REG_TAG    1

//* control state machine
`define IF_STATE    4'b0000 // * if state
`define ID_STATE    4'b0001 // * id state
`define EXE1_STATE  4'b0010 // * exe for lw or sw
`define EXE2_STATE  4'b0011 // * exe for add/sub...(R&I type together)
`define EXE3_STATE  4'b0100 // * exe for branch (beq & bne)
`define EXE4_STATE  4'b0101 // * exe for j inst
`define MEM1_STATE  4'b0110 // * mem for lw - memread
`define MEM2_STATE  4'b0111 // * mem for sw - memwrite
`define WB1_STATE   4'b1000 // * write back for memory inst
`define WB2_STATE   4'b1001 // * write back for add/sub...
