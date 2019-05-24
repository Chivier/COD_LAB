module counter #(parameter cnt=9)
    (
    input clk,
    input enable,
    input reset,
    output carry,
    output reg [3:0] Q
    );
    assign carry=(Q==cnt)?1:0;
    initial
    begin
    Q<=0;
    end
    always@(posedge clk,posedge reset)
    begin
        if(reset)
        Q<=0;
        else if(enable)
        if(Q>=cnt)
            Q<=0;
        else 
            Q=Q+1; 
    end
    
endmodule
