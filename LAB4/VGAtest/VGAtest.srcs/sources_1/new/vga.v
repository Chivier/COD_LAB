module hvsync_generator(board_clk, reset,vga_h_sync, vga_v_sync ,color);
input board_clk;
input reset;
output vga_h_sync, vga_v_sync;
output color;

reg [19:0] CounterX;
reg [19:0] CounterY;
reg vga_HS, vga_VS;
reg inDisplayArea;
reg [11:0] color;

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
   else if(CounterX==19'd1040)
	   CounterX <= 0;
   else
	   CounterX <= CounterX +1;
end
always @(posedge clk, posedge reset)
begin
   if(reset)
      CounterY<=0; 
   else if(CounterY==19'd666)
      CounterY<=0;
   else if(CounterX==19'd1040)
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
always @*
begin 
if (inDisplayArea)
color = 12'b1111_0000_1111;
else
color = 0;
end

endmodule
