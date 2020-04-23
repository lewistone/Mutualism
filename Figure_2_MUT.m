%Fig.2   with Exploitative interactions in background
clear all; close all;
S=100;
C=0.7;
sigma=0.02;
r=ones(S,1);
repeats=50;
num=60;                                %Percentage max of Pm  Pairs of Mutualists
STAB=zeros(num-1,1);

for rep=1:repeats
for u=1:(num-1)
Pm=(u)/100;
feasible=0;

while feasible==0
a=zeros(S);
for i=1:S for j=(i+1):S 
        if rand<C 
               rr=rand;
               %make mutualistic
             if rr>(1-Pm) a(i,j)= sigma*abs(randn(1)); a(j,i)= sigma*abs(randn(1)); end;
             if rr<(1-Pm)
               %make explotative  
                 rr2=rand;
                    if rr2<0.5  a(i,j)=sigma*abs(randn(1)); a(j,i)=-sigma*abs(randn(1));  end;
                    if rr2>0.5  a(j,i)=sigma*abs(randn(1)); a(i,j)=-sigma*abs(randn(1));end;
             end;
        end;  %if
    end;end;

for i=1:S a(i,i)=-1; end;

N=-inv(a)*r;     %equilibria
feasible=1;
for i=1:S if N(i)<0 feasible=0; end;end;
end; %while


%We have a feasible matrix now    
D=zeros(S,S);
for i=1:S D(i,i)=N(i);end;
 STAB(u)=STAB(u)+real(eigs(D*a,1,'LR'))/repeats;
 x(u)=Pm;
 
end;  %Pm
end;  % repeats


plot(x,STAB,'r','LineWidth',3,'MarkerSize',6) 
 ylabel('Eigenvalue  \Lambda');
xlabel('Proportion mutualists');

set(gca,'XTick',[0  0.2 0.4 0.6 ]);
set(gca,'YTick',[-1 -0.8 -0.6 -0.4 -0.2 ]);
set(gca, 'FontWeight', 'Bold');
set(gca,'fontsize',12);


