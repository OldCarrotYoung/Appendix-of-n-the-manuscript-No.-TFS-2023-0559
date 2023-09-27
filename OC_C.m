function [OC]=OC_C(NUM_DMs,DD)
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
for iii=1:NUM_DMs
    OC(iii)=sum(C(iii,:)); %calculate \sum_j=1^I c(ji)
end
OC(isnan(OC))=0;
end