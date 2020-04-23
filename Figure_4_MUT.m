%Figure 4
%This version no competitive interactions now
%Totally exploitative

clear all; close all;
S=100;
aii=1;
C=0.7;
sig=0.02;
num=30;   % Number of values for P

for u=1:num
P=0.6*u/(num);
TOTpairs=S*(S-1)/2;
pairs=round(P*TOTpairs);    %Cooperative pairsfeasible=0;
while feasible==0
    A=zeros(S);
    A=sig*randn(S);  % A has elements mean zero and variance sig^2
    for i=1:S A(i,i)=-1; end;

%Find ESTIMATE OF mean values of abs(Ai,j)
mm=0;
for i=1:1000 mm=mm+sig*abs(randn)/1000;end

%REMOVE all competition and Mutualism. Make Totally Exploitative
for i=1:S for j=(i+1):S 
         if A(i,j)>0 A(j,i)=-abs(A(j,i));end;
          if A(i,j)<0 A(j,i)=abs(A(j,i));end;
    end;end;

% ADD Cooperative pairs
np=0;
while np<pairs
    same =1;
    while same==1;
        j=randi(S)+0;
        k=randi(S)+0;
        if j~=k same=0;end;
    end; 
        A(j,k)=abs(A(j,k));
        A(k,j)=abs(A(k,j));
     np=0;     %Count number of mutualist pairs
    for i=1:S for j=(i+1):S if (A(i,j)>0  & A(j,i)>0) np=np+1;end;
    end; end;
end; %pairs while

npp=np/TOTpairs*100;
%Add Connectance
for i=1:S for j=(i+1):S
        if rand>C A(i,j)=0; A(j,i)=0; end;
    end;end;

%Calculate number of relevant nonzero interactions
NumInt=S*(S-1);       
sum=0;
for i=1:S for j=1:S
        if i~=j  sum=sum+A(i,j);end;end;end;
meanm(u)=1/(1-(S-1)*sum/NumInt);    
meanm(u)=1/(1-(S-1)*mm*P*C);


N=-inv(A)*ones(S,1);      %equilibrium populations
Nmean(u)=mean(N);
Nmin(u)=min(N);
feasible=1;
 for i=1:S if N(i)<0 feasible=0; end;end;
 end;  %while feasible loop
    
D=zeros(S);
for i=1:S D(i,i)=N(i);end;
STAB=real(eig(D*A));
emax(u)=max(STAB);
x(u)=P; 
end;

plot(x,Nmean,'g',x,Nmin,'c',x,-emax,'k',x,meanm,'om','MarkerSize',0.5,'LineWidth',4);
xlabel('P - Proportion mutualism');

str = '<N_i^*>';

text(0.36,2,str,'FontSize',13,'FontWeight', 'Bold');
str = 'N_i^*(min)';
text(0.52,2,str,'FontSize',13,'FontWeight', 'Bold');

str = '- \Lambda';
text(0.55,0.8,str,'FontSize',13,'FontWeight', 'Bold');

xticks([0:0.2:0.6]);

 set(get(gca,'title'),'FontSize', 2, 'FontWeight', 'Bold');
 box off; axis square;
 set(gca,'LineWidth',2);
 set(gca,'FontSize',12);
set(gca,'FontWeight','Bold');
set(gcf,'color','w');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [8 8]);
set(gcf,'PaperPosition',[0.5 0.5 7 7]);
set(gcf,'PaperPositionMode','Manual');
