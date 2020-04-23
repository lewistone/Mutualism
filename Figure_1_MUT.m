% Figure 1 code
close all; clear all, clear global
global rr N  A
N=10;                         
sig=0.05;  
for i=1:N rr(i)=1; end; 
for i=1:N Pert(i)=0; end;
for i=2:2 Pert(i)=0.4; end;    %Species-2 is perturbed


for mchange=1:2        %Number of mu values
for trial=1:5
if mchange==2 mu=0.1;else mu=0; end;
A=zeros(N);
for i=1:N for j=1:N A(i,j)=mu+sig*randn; end;end;
  for i=1:N A(i,i)=-1;end;
  Nstar=-inv(A)*rr';                    %Population Equilibria
  
  for i=1:N V(i)=Nstar(i)-Pert(i); end;
   
D=zeros(N);
for i=1:N D(i,i)=Nstar(i);end;
DA=D*A;                                     % Community Matrix
STAB=eig(D*A);

tspan=0:0.01:5;
[T,Y] = ode15s(@L_V,[tspan],V);
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

if mchange==1 plot(T,Y(:,2)-Nstar(2),'b','LineWidth',2.5);end;
if mchange==2 plot(T,Y(:,2)-Nstar(2),'r','LineWidth',2.5); end;
hold on
       
end;   %trial

end; mchange;
text(2.25,-0.11,'m=0','FontSize',12,'FontWeight','bold');
text(0.5,-0.04,'m=0.1','FontSize',12,'FontWeight','bold');
set(gca, 'FontWeight', 'Bold');
set(gca, 'FontSize', 14);
xlabel('time');
ylabel('Perturbation');
yticks([-0.4:0.1:0]);
xticks([0:1:5]);


function dy = L_V(t,y)
dy = zeros(2,1);
global rr N A

for i=1:N dy(i)=rr(i)*y(i);end;
for i=1:N  for j=1:N
dy(i) = dy(i)+ y(i)*y(j)*A(i,j);
    end;end;
end



