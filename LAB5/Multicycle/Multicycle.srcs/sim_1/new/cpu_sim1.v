`timescale 1ns / 1ps
`include "define.v"

module cpu_sim1();

 reg    rst   ; 
 reg    clk   ; 
 reg [`REG_BUS] dpra;
 wire [`REG_BUS] dpo;
 wire [`REG_BUS] pcout;
 wire [`REG_BUS] regdata;

reg cont;
reg step;
reg mem;
reg inc;
reg dec;
                        
//wire [`REG_BUS] memshow;
wire [`REG_BUS] pc;
wire clkout;
wire [`REG_BUS] addrout;
wire [`REG_BUS] memdata;
wire delay1;
wire delay2;
wire [`NUM5_BUS] num5;
wire [`REG_BUS] irrun;
wire [`REG_BUS] numa;
wire [`REG_BUS] numb;
 initial
 begin
   rst<=0;
   cont<=0;
   inc<=0;
   dec<=0;
   mem<=0;
   step<=0;
   #10 rst = 1;
   #10 rst = 0;
   #20 step = 1;
   #10 step = 0;
   #10 mem = 1;
       inc = 1;
   #10 inc = 0;
   #10 inc = 1;
   #10 inc = 0;
   #10 inc = 1;
   #10 inc = 0;
   #10 inc = 1;
   #10 inc = 0;
   #10 inc = 1;
   #10 inc = 0;
      #10 inc = 1;
      #10 inc = 0;
         #10 inc = 1;
         #10 inc = 0;
            #10 inc = 1;
            #10 inc = 0;
               #10 step = 1;
               #10 step = 0;
                  #10 step = 1;
                  #10 step = 0;
                     #10 step = 1;
                     #10 step = 0;
                        #10 step = 1;
                        #10 step = 0;
                           #10 step = 1;
                           #10 step = 0;
                              #10 step = 1;
                              #10 step = 0;
                                 #10 step = 1;
                                 #10 step = 0;
                                    #10 step = 1;
                                    #10 step = 0;
                                       #10 step = 1;
                                       #10 step = 0;
                                          #10 step = 1;
                                          #10 step = 0;
                                             #10 step = 1;
                                             #10 step = 0;
                                                #10 step = 1;
                                                #10 step = 0;
                                                   #10 step = 1;
                                                   #10 step = 0;
                                                      #10 step = 1;
                                                      #10 step = 0;
                                                         #10 step = 1;
                                                         #10 step = 0;
                                                            #10 step = 1;
                                                            #10 step = 0;
                                                               #10 step = 1;
                                                               #10 step = 0;
   #10 mem = 0;
   #10000;
 end
 
 initial clk<=0;
 always #5 clk<=~clk;
 always begin #10 step = 1; #20 step = 0; end
 //cpu DUT ( .clk (clk), .rst(rst), .pcout (pcout) , .inputaddr(dpra), .memout_show(dpo), .regout_show(regdata));
 wire pc_write;
 //wire [`REG_BUS] jext; 
 wire [`STATE_BUS] state;
 //ddu DUT (cont,rst,clk,step,mem,inc,dec,memshow,addrout,pc,clkout,memdata,pc_write,jext,num5,state,irrun);
 
 //output reg [`REG_BUS] memshow,
 wire [7:0] addrout_8;
 wire [7:0] pc_8;
 //output reg clktest,
 //output wire [`REG_BUS] memdata,

 //output wire [`REG_BUS] jext,
 //output wire [`NUM5_BUS] num5,
 //output wire [`STATE_BUS] state,
 //output wire [`REG_BUS] irrun,
 wire [6:0] seg;
 wire [7:0] an;
 //wire [1023:0] reg_clone;
 wire reg_write;
  wire [31:0] memmdr;
  wire [31:0] mem2;
 //ddu DUT (cont,rst,clk,step,mem,inc,dec,memshow,addrout_8,pc_8,state,irrun,seg,an,reg_clone,reg_write,memmdr);
 ddu DUT (cont,rst,clk,step,mem,inc,dec,addrout_8,pc_8,pc_write,state,irrun,seg,an,mem2,numa,numb);
  /*
 reg [31:0] regi [0:31];
 integer i;
 always @* begin
         for (i = 0; i < 32 ; i = i + 1) begin
             regi[i] = reg_clone >> (32 * i);
         end
         end*/
endmodule
