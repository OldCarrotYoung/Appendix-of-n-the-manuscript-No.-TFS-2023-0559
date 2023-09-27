clc; clear; close all;
%% Baisc information
M=4;%number of alternatives
N=3;%number of attributs
DSC=zeros(1,100);%confidence level matrix
NUM_DMs=100;
I=NUM_DMs;%number of decision makers
load 'D100.mat'
DD=data;
D0=DD;
E=1:NUM_DMs;
t=0; 
D_ACC=data; %recommendation plan that has been accepted
D_MID=data; %evaluation of all decison makers after one consensus rounds
INDEX_DM_RE=zeros(I,4);
%% Parameter setting
RE=0.6666; %rejection probability
delta=0.5; %punishment
T=20; %maximum of the number of consensus rounds
Ot=zeros(T,I);%observation set
miu=0.08; %threshold for GCD
YITA=[0.25 0.25 0.25 0.25];%weight vector of alternatives
YIPUSILONG=[1/3;1/3;1/3];%weight vector of attributes
gamma1=0.15;gamma2=0.8;%threshold for clustering method
spsilon1=0.15;spsilon2=0.8;%threshold for clustering method
rho=0.45;%modification rate
r=rho; 
u=1-r; 
%% Calculation of confidence levels of DMs
 AS=data';
 num_dm=1;
while num_dm<=NUM_DMs
    DSCi=ones(M,N);
    num_miu=1;
    num_columns=1;
    MIU=zeros(1,12);
    V=zeros(1,12);
    while num_columns<=24
        MIU(num_miu)=AS(num_dm,num_columns);
        num_miu=num_miu+1;
        num_columns=num_miu*2-1;
    end
    num_columns=2;
    num_v=1;
    while num_columns<=24
        V(num_v)=AS(num_dm,num_columns);
        num_v=num_v+1;
        num_columns=num_columns+2;
    end
    Vi=reshape(V,N,M)';
    MIUi=reshape(MIU,N,M)';
    DSCi=DSCi-MIUi-Vi;
    DSCimiddle=zeros(1,N); 
    n=1;
    while n<=N
        partofDSCi=DSCi(1:M,n);
        partofDSCi=partofDSCi';
        DSCimiddle(n)=sum(partofDSCi.*YITA);
        n=n+1;
    end
    DSCimiddle=DSCimiddle';
    DSCi=sum(DSCimiddle.*YIPUSILONG);
    DSC(num_dm)=DSCi;
    num_dm=num_dm+1;
end
eval(['OC_',num2str(t),'=OC_C(I,DD);']);
eval(['BC_',num2str(t),'=BC_C(I,DD);']);
eval(['CD_',num2str(t),'=CD_C(I,DD);']);
eval(['C_',num2str(t),'=C_C(I,DD);']);
eval(['W=WEIGHT_C(I,D',num2str(t),');']);
W=W';
eval(['weight',num2str(t),'=W;']);
GCD0=eval(['CD_',num2str(t),'*weight',num2str(t),';']);
%% CC-CRP
if GCD0>miu
   while t<T
%% Clustering process
     eval(['S',num2str(t+1),'=CLUSTER(CD_',num2str(t),',OC_',num2str(t),',BC_',num2str(t),',DSC,I,gamma1,gamma2,spsilon1,spsilon2);']);
%% recommendation and feedback process
     eval(['ER_',num2str(t+1),'=zeros(I,2);']);
     for i=1:I
         eval(['ER_',num2str(t+1),'(i,1)=CD_',num2str(t),'(i)/DSC(i);']);
         eval(['ER_',num2str(t+1),'(i,2)=i;']);
     end
     eval(['ER=ER_',num2str(t+1),';']);
     rank_ER=sortrows(ER,1);
     k=0;
     tt=0;
     ttt=0;
     Rand=rand(1,100);
     REJECT=zeros(1,100);
     for jjj=1:100
         if Rand(1,jjj)<=RE
            REJECT(1,jjj)=1;
         end
     end
     while k==0
       while REJECT(1,ttt+1)==1
             eval(['Ot(t+1,',num2str(rank_ER(I-ttt,2)),')=1;'])
             tt=tt+1;
             ttt=ttt+1;
       end 
       index_dm=rank_ER(I-tt,2);
       GCD_NEW=zeros(100,2);
       for i=1:100 
           D_Z=DD*10000; 
           D_Z(:,index_dm)=u*D_Z(:,index_dm)+r*D_Z(:,i);
           %Calculate GCD
           D_Z=D_Z/10000;
           CD_Z=CD_C(I,D_Z);
           GCD_Z=CD_Z*eval(['weight',num2str(t),';']);
           GCD_NEW(i,1)=GCD_Z;
           GCD_NEW(i,2)=i;
       end
       %按减少的冲突度进行排序
       rank_GCD_NEW=sortrows(GCD_NEW,1);
       if rank_GCD_NEW(1,1)<eval(['GCD',num2str(t)])
          MAX_REDUCE=rank_GCD_NEW(1,2);
          D_MID=DD*10000;
          D_MID(:,index_dm)=u*D_MID(:,index_dm)+r*D_MID(:,MAX_REDUCE);
          D_MID=D_MID/10000;
          t=t+1;
          eval(['index_dm_',num2str(t),'=index_dm;']);
          eval(['index_re_',num2str(t),'=MAX_REDUCE;']);
          eval(['group_dm_',num2str(t),'=GROUPDETECT(index_dm_',num2str(t),',S',num2str(t),');']);
          eval(['group_re_',num2str(t),'=GROUPDETECT(index_re_',num2str(t),',S',num2str(t),');']);
          eval(['INDEX_DM_RE(t,1)=index_dm_',num2str(t),';']);
          eval(['INDEX_DM_RE(t,2)=group_dm_',num2str(t),';']);
          eval(['INDEX_DM_RE(t,3)=index_re_',num2str(t),';']);
          eval(['INDEX_DM_RE(t,4)=group_re_',num2str(t),';']);     
          eval(['OC_',num2str(t),'=OC_C(I,D_MID);']);
          eval(['BC_',num2str(t),'=BC_C(I,D_MID);']);
          eval(['CD_',num2str(t),'=CD_C(I,D_MID);']);
          eval(['C_',num2str(t),'=C_C(I,D_MID);']);
          eval(['D',num2str(t),'=D_MID;']);
          eval(['weight',num2str(t),'=weight',num2str(t-1),';'])
          %Punishment
          sum_weight=0;
          for ii=1:I
              if eval(['Ot(',num2str(t),',ii)==1'])
                 eval(['group_reject=GROUPDETECT(ii,S',num2str(t),');']);
                 if group_reject==4||group_reject==5||group_reject==6||group_reject==10||group_reject==11||group_reject==12
                    sum_weight=sum_weight+eval(['weight',num2str(t),'(ii,1)*delta;']);
                    eval(['weight',num2str(t),'(ii,1)=weight',num2str(t),'(ii,1)*(1-delta);']);
                 end
              end
          end
          num_s13=sum(eval(['S',num2str(t),'(13,:);']));
          for ii=1:I
              eval(['group_reward=GROUPDETECT(ii,S',num2str(t),');']);
              if group_reward==13
                 eval(['weight',num2str(t),'(ii,1)=weight',num2str(t),'(ii,1)+sum_weight/num_s13;']);
              end
          end
          eval(['GCD',num2str(t),'=CD_',num2str(t),'*weight',num2str(t),';']);
          eval(['GCD=GCD',num2str(t),';']);
          disp(['No. ',num2str(t),' consensus round ends. The updated GCD is ',num2str(GCD)]);
          DD=D_MID;
          k=k+1;
       else
          tt=tt+1;
       end
       if eval(['GCD',num2str(t),'<miu'])
          eval(['GCD=GCD',num2str(t),';']);
          disp(['CC-CRP successes. The final value of GCD is ',num2str(GCD)]);
          eval(['GCD',num2str(T),'=GCD',num2str(t),';']);
          t=T+1;
       end
     end
   end
   if eval(['GCD',num2str(T),'>miu'])
      disp('CC-CRP fails.');
   end
end


