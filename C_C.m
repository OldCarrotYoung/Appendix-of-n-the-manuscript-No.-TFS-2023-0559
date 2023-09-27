function [C]=C_C(NUM_DMs,DD)
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
end