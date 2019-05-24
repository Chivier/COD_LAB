`timescale 1ns / 1ps

`define ColorBUS 11:0
`define DirBUS   3:0
`define PenBUS   7:0

module DCU (board_clk,reset,we,Penx,Peny,colorst,vga_h_sync,vga_v_sync,color);
input board_clk;
input reset;
input Penx;
input we;
input Peny;
input colorst;
output vga_h_sync, vga_v_sync;
output color;

wire [`ColorBUS] colorst;
reg [`ColorBUS] Color;
reg [19:0] CounterX;
reg [19:0] CounterY;
wire we;
wire [7:0] Xreq;
wire [7:0] Yreq;
reg vga_HS, vga_VS;
wire [7:0] Penx;
wire [7:0] Peny;
reg inDisplayArea;
reg [`ColorBUS] color;
wire [`ColorBUS] Colout;

	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)
	begin : CLOCK_DIVIDER
      if (reset)
			begin
				DIV_CLK <= 0;
			end
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
wire clk;
assign clk = DIV_CLK[0];

always @(posedge clk, posedge reset)
begin
   if(reset)
      CounterX <= 0;
   else if(CounterX==19'd1056)
	   CounterX <= 0;
   else
	   CounterX <= CounterX +1;
end
always @(posedge clk, posedge reset)
begin
   if(reset)
      CounterY<=0;
   else if(CounterY==19'd628)
      CounterY<=0;
   else if(CounterX==19'd1056)
      CounterY <= CounterY + 1;
end
always @(posedge clk)
begin
	vga_HS <= (CounterX>855 && CounterX<976);
	vga_VS <= (CounterY>636 && CounterY<643);
end


always @(posedge clk)
   if(reset)
      inDisplayArea<=0;
   else
	   inDisplayArea <= (CounterX<800) && (CounterY<600);

assign vga_h_sync = ~vga_HS;
assign vga_v_sync = ~vga_VS;

assign Yreq = CounterY - 172 ;
assign Xreq = CounterX - 272 ;
VRAM Ld (Penx,Peny,colorst,we,clk,Xreq,Yreq,Colout);
always @*
begin
if (inDisplayArea)
begin
    if (CounterX >= 272 && CounterX <= 272+255 && CounterY>=172 && CounterY<=172+255)
    begin
        if ((Xreq == Penx && (Yreq > Peny && Yreq-Peny <=3 || Peny > Yreq && Peny-Yreq <=3)) ||
            (Yreq == Peny && (Xreq > Penx && Xreq-Penx <=3 || Penx > Xreq && Penx-Xreq <=3)))
            color <= 0;
        else
            color <= ~Colout;
    end
    else
    begin
        color <= 0;
    end
end
else
color = 0;
end

endmodule
