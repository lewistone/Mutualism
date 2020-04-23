%Figure 3   Totally exploitative background
clear all; close all;
S=100;
aii=1;
C=0.7;
sig=0.02;
num=4;                         %Four Panels for different P values

for u=1:num    
P=(u-1)/4;
if u==1 P=0.0; end;
if u==2 P=0.2; end;
if u==3 P=0.5; end;
if u==4 P=0.8; end; 
TOTpairs=S*(S-1)/2;
pairs=round(P*TOTpairs);    %Cooperative pairs

feasible=0;
while feasible==0
A=zeros(S);
A=sig*randn(S);              % A has elements mean zero and variance sig^2
for i=1:S A(i,i)=-aii; end;

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
np=0;
    for i=1:S for j=(i+1):S if (A(i,j)>0  & A(j,i)>0) np=np+1;end;
    end; end;
end; %pairs while
npp=np/TOTpairs*100;

%Add Connectance
for i=1:S for j=(i+1):S
        if rand>C A(i,j)=0; A(j,i)=0; end;
    end;end;

N=-inv(A)*ones(S,1);     %Equilibrium populations
Nmean(u)=mean(N);
feasible=1;
for i=1:S if N(i)<0 feasible=0; end;end;
end;  %while feasible loop
    
   
D=zeros(S,S);
for i=1:S D(i,i)=N(i);end;
if u==1 STAB=eig(D*A); end;
if u==2 STAB2=eig(D*A); end;
if u==3 STAB3=eig(D*A); end;
if u==4 STAB4=eig(D*A); end;
if u==5 STAB5=eig(D*A); end;
 
end;

kk=8;fs=11;

subplot(5,1,1);
n=length(STAB);
plot(STAB,'r.') ;
hold on;
plot(-kk,0,0,0,'y.','MarkerSize',0.01);
hold on;
plot(-Nmean(1),-0.3,'b.','MarkerSize',28);
title('P=0');
set(gca, 'FontWeight', 'Bold');
set(gca, 'FontSize', fs);

subplot(5,1,2);
n=length(STAB2);
plot(STAB2,'r.') 
hold on;
plot(-kk,0,0,0,'y.','MarkerSize',0.01);
hold on;
plot(-Nmean(2),-0.3,'b.','MarkerSize',28);
title('P=0.2');
set(gca, 'FontWeight', 'Bold');
set(gca, 'FontSize', fs);

subplot(5,1,3);
n=length(STAB3);
plot(STAB3,'r.') 
hold on;
plot(-kk,0,0,0,'y.','MarkerSize',0.01);
hold on;
plot(-Nmean(3),-0.39,'b.','MarkerSize',28);
title('P=0.5');
yticks(-0.2:0.2:0.2);
set(gca, 'FontWeight', 'Bold');
set(gca, 'FontSize', fs);


subplot(5,1,4);
n=length(STAB4);
plot(STAB4,'r.') 
hold on;
plot(-kk,0,0,0,'y.','MarkerSize',0.01);
 hold on;
plot(-Nmean(4),-1,'b.','MarkerSize',28);
title('P=0.8');
set(gca, 'FontWeight', 'Bold');
set(gca, 'FontSize', fs);

