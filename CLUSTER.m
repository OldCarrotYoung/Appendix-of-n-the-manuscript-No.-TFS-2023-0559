function [S]=CLUSTER(CD,OC,BC,DSC,I,gamma1,gamma2,spsilon1,spsilon2)
upsilon=zeros(1,I);
omega=zeros(1,I); 
psi=zeros(1,I);
AC=sum(BC)/I;
for j=1:I
    if OC(1,j)==BC(1,j)
       if OC(1,j)==0
          upsilon(1,j)=1; 
       else
          if OC(1,j)>=AC
             omega(1,j)=1;
          else
             psi(1,j)=1;
          end
       end
    else
        if OC(1,j)>BC(1,j)
           omega(1,j)=1;
        else
           psi(1,j)=1;
        end
    end
end
rank_DSC=sort(DSC);
rank_CD=sort(CD);
gamma_1=rank_CD(gamma1*I);
gamma_2=rank_CD(gamma2*I);
spsilon_1=rank_DSC(spsilon1*I);
spsilon_2=rank_DSC(spsilon2*I);
S1=zeros(1,I);S2=zeros(1,I);S3=zeros(1,I);S4=zeros(1,I);S5=zeros(1,I);S6=zeros(1,I);
S7=zeros(1,I);S8=zeros(1,I);S9=zeros(1,I);S10=zeros(1,I);S11=zeros(1,I);S12=zeros(1,I);S13=zeros(1,I);
for i=1:I
    if CD(i)<=gamma_1
       S13(i)=1;
    else
       if CD(i)<=gamma_2
          if DSC(i)<=spsilon_1
             if omega(i)==1
                S1(i)=1;
             else
                S7(i)=1;
             end
          else
             if DSC(i)<=spsilon_2
                if omega(i)==1
                   S2(i)=1;
                else
                   S8(i)=1;
                end
             else 
                if omega(i)==1
                   S3(i)=1;
                else
                   S9(i)=1;
                end
             end
         end
       else
              if DSC(i)<=spsilon_1
                 if omega(i)==1
                    S4(i)=1;
                 else
                    S10(i)=1;
                 end
              else
                 if DSC(i)<=spsilon_2
                    if omega(i)==1
                       S5(i)=1;
                    else
                       S11(i)=1;
                    end
                 else 
                     if omega(i)==1
                        S6(i)=1;
                     else
                        S12(i)=1;
                     end
                 end
             end
       end
    end
end
S=zeros(13,I);
for i=1:13
    eval(['S(i,:)=S',num2str(i),'(1,:);']);
end
end