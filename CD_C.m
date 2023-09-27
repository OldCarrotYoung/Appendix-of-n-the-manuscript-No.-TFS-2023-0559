function [CD]=CD_C(NUM_DMs,DD)
I=NUM_DMs;
SR_coeffcients=zeros(I,I);
for i=1:NUM_DMs
    y=DD(:,i);
    D_=DD;
    D_(:,i)=0;%AMR Operator
    beta=SR(D_,y);
    SR_coeffcients(:,i)=beta;%column
end
SR_coeffcients(SR_coeffcients>0)=0;
C=abs(SR_coeffcients);  
OC=zeros(1,NUM_DMs); 
BC=OC;
for iii=1:NUM_DMs
    BC(iii)=sum(C(:,iii)); %calculate \sum_j=1^I c(ij)   
    OC(iii)=sum(C(iii,:)); %calculate \sum_j=1^I c(ji)
end
OC(isnan(OC))=0;
BC(isnan(BC))=0;
CD=zeros(1,NUM_DMs);
for j=1:NUM_DMs
    if OC(1,j)==BC(1,j)
       if OC(1,j)==0
          CD(1,j)=0;
       end
    else
       if OC(1,j)>=BC(1,j)
          CD(1,j)=OC(1,j);
       else
          if OC(1,j)<BC(1,j)
             CD(1,j)=BC(1,j);
          end
       end
    end
end
end