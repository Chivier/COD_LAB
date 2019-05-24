module clk10HZ(
    input clk5MHZ,
    output reg Q
    );
    reg[0:23]count; 
    initial
    begin
        count=0;
        Q=0;
    end
    
    always@(posedge clk5MHZ)
            if(count>=24'd249999)
            begin
                count<=24'b0;
                Q<=~Q;
            end
            else
                count<=count+24'h1;
endmodule
