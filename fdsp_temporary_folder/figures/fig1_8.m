function fig1_8

% FIGURE 1.8:  A discrete-time signal x(k)

clc
clear
fprintf ('Figure 1.8: A discrete-time signal x(k)\n\n')
f = inline ('10*t.*exp(-t)','t');
p = 101;
tau = 4;
t = linspace(0,tau,p);
x_a = f(t);

% Discrete time

figure
n = 16;
T = tau/n
k = [0 : n-1];
x = f(k*T);
r = plot(t,x_a,'--',k*T,x,'o');
set (r(2),'LineWidth',1.5)
xticks = [0 : .25 : 4];
set(gca,'XTick',xticks)
xticklabels = '0 | | .5 | | 1 | | 1.5 | | 2 | | 2.5 | | 3 | | 3.5 | | 4';
set(gca,'XTickLabel',xticklabels)
f_labels ('{\itx(k) = 10kT} exp{\it(-kT)}','{\itkT} (sec)','\it{x(k)}')
text (1,1.5,'{\itT} = 0.25') 
f_wait
