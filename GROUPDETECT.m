function [GROUP_NO]=GROUPDETECT(MAX_REDUCE,S)
  if  S(1,MAX_REDUCE)==1
      GROUP_NO=1;
  else
      if S(2,MAX_REDUCE)==1
         GROUP_NO=2;
      else
         if S(3,MAX_REDUCE)==1
            GROUP_NO=3;
         else
            if S(4,MAX_REDUCE)==1
               GROUP_NO=4;
            else
               if S(5,MAX_REDUCE)==1
                  GROUP_NO=5;
               else
                  if S(6,MAX_REDUCE)==1
                     GROUP_NO=6;
                  else
                     if S(7,MAX_REDUCE)==1
                        GROUP_NO=7;
                     else
                        if S(8,MAX_REDUCE)==1
                           GROUP_NO=8;
                        else
                           if S(9,MAX_REDUCE)==1
                              GROUP_NO=9;
                           else
                              if S(10,MAX_REDUCE)==1
                                 GROUP_NO=10;
                              else
                                 if S(11,MAX_REDUCE)==1
                                    GROUP_NO=11;
                                 else
                                    if S(12,MAX_REDUCE)==1
                                       GROUP_NO=12;
                                    else
                                       GROUP_NO=13;
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            end
         end
      end
  end
end

                                    
                       