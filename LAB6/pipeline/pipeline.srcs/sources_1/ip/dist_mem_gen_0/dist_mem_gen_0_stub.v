// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Mon May 20 12:38:23 2019
// Host        : DESKTOP-M866AGS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/Study/Subject_L/COD_LAB/LAB6/pipeline/pipeline.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_stub.v
// Design      : dist_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.2" *)
module dist_mem_gen_0(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[4:0],spo[31:0]" */;
  input [4:0]a;
  output [31:0]spo;
endmodule
