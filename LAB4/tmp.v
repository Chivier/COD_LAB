
            if (Dir[3] && !Dirdelay[3]) // down appear
            begin
                cl = 0;
                Shortmove = 1;
                if (cr + cd + cu > 0)
                begin
                    Xflag = 1;
                    if (cd > 0) Movex[2] = 1;
                    else Movex[3] = 1;
                end
            end
            
            if (Dir[3] && Dirdelay[3]) // down remain
            begin
                cl = cl + 1;
                if (!Xflag && cl > 200000000)
                begin
                    Shortmove = 0;
                    if ((cl - 200000000) % 100000000 == 0)
                    llmove = llmove + 3;
                end
            end
            
            if (!Dir[3] && Dirdelay[3]) // down end
            begin
                if (Xflag)
                begin
                    if (cr + cd + cu == 0)
                    begin
                        if (Movex[2])
                        begin
                            Xcor = (Xcor == 255 ? 255 : Xcor + 1);
                            Ycor = (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        else
                        begin
                            Xcor = (Xcor == 0 ? 0 : Xcor - 1);
                            Ycor = (Ycor == 0 ? 0 : Ycor - 1);
                        end
                        cl = 0;
                        Movex = 0;
                        Xflag = 0;
                    end
                    else
                        cl = 0;
                end
                else
                begin
                    if (Shortmove)
                        Ycor = (Ycor == 0 ? 0 : Ycor - 1);
                end
            end

            if (llmove > 0)
            begin
                llmove = llmove - 1;
                Ycor = (Ycor == 0 ? 0 : Ycor - 1);
            end