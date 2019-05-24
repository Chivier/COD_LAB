assign W_active_flag =  (R_h_cnt >= (C_H_SYNC_PULSE + C_H_BACK_PORCH                  ))  &&
                        (R_h_cnt <= (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_H_ACTIVE_TIME))  && 
                        (R_v_cnt >= (C_V_SYNC_PULSE + C_V_BACK_PORCH                  ))  &&
                        (R_v_cnt <= (C_V_SYNC_PULSE + C_V_BACK_PORCH + C_V_ACTIVE_TIME))  ;                     

//////////////////////////////////////////////////////////////////
// 功能：把显示器屏幕分成8个纵列，每个纵列的宽度是80
//////////////////////////////////////////////////////////////////
always @(posedge R_clk_25M or negedge I_rst_n)
begin
    if(!I_rst_n) 
        begin
            O_red   <=  5'b00000    ;
            O_green <=  6'b000000   ;
            O_blue  <=  5'b00000    ; 
        end
    else if(W_active_flag)     
        begin
            if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH)) // 红色彩条
                begin
                    O_red   <=  5'b11111    ; // 红色彩条把红色分量全部给1，绿色和蓝色给0
                    O_green <=  6'b000000   ;
                    O_blue  <=  5'b00000    ;
                end
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*2)) // 绿色彩条
                begin
                    O_red   <=  5'b00000    ;
                    O_green <=  6'b111111   ; // 绿色彩条把绿色分量全部给1，红色和蓝色分量给0
                    O_blue  <=  5'b00000    ;
                end 
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*3)) // 蓝色彩条
                begin
                    O_red   <=  5'b00000    ;
                    O_green <=  6'b000000   ;
                    O_blue  <=  5'b11111    ; // 蓝色彩条把蓝色分量全部给1，红色和绿分量给0
                end 
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*4)) // 白色彩条
                begin
                    O_red   <=  5'b11111    ; // 白色彩条是有红绿蓝三基色混合而成
                    O_green <=  6'b111111   ; // 所以白色彩条要把红绿蓝三个分量全部给1
                    O_blue  <=  5'b11111    ;
                end 
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*5)) // 黑色彩条
                begin
                    O_red   <=  5'b00000    ; // 黑色彩条就是把红绿蓝所有分量全部给0
                    O_green <=  6'b000000   ;
                    O_blue  <=  5'b00000    ;
                end 
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*6)) // 黄色彩条
                begin
                    O_red   <=  5'b11111    ; // 黄色彩条是有红绿两种颜色混合而成
                    O_green <=  6'b111111   ; // 所以黄色彩条要把红绿两个分量给1
                    O_blue  <=  5'b00000    ; // 蓝色分量给0
                end 
            else if(R_h_cnt < (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_COLOR_BAR_WIDTH*7)) // 紫色彩条
                begin
                    O_red   <=  5'b11111    ; // 紫色彩条是有红蓝两种颜色混合而成
                    O_green <=  6'b000000   ; // 所以紫色彩条要把红蓝两个分量给1
                    O_blue  <=  5'b11111    ; // 绿色分量给0
                end 
            else                              // 青色彩条
                begin
                    O_red   <=  5'b00000    ; // 青色彩条是由蓝绿两种颜色混合而成
                    O_green <=  6'b111111   ; // 所以青色彩条要把蓝绿两个分量给1
                    O_blue  <=  5'b11111    ; // 红色分量给0
                end                   
        end
    else
        begin
            O_red   <=  5'b00000    ;
            O_green <=  6'b000000   ;
            O_blue  <=  5'b00000    ; 
        end           
end