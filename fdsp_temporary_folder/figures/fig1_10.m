function fig1_10

% FIGURE 1.10: A digital signal x_q(k)

clc
clear
fprintf ('Figure 1.10: A digital signal x_q(k)\n\n')
f = inline ('10*t.*exp(-t)','t');
p = 101;
tau = 4;
t = linspace(0,tau,p);
x_a = f(t);

% Digital

figure
n = 16;
T = tau/n
k = [0 : n-1];
x = f(k*T);
xticks = [0 : .25 : 4];
set(gca,'XTick',xticks)
xticklabels = '0 | | .5 | | 1 | | 1.5 | | 2 | | 2.5 | | 3 | | 3.5 | | 4';
set(gca,'XTickLabel',xticklabels)
bits = 5;
q = 4/(2^bits - 1)
xq = q*round(x/q);
r = plot(t,x_a,'--',k*T,xq,'s');
set (r(2),'LineWidth',1.5)
f_labels ('{\itx_q(k) = Q_N [x_a(kT)]}','{\itkT} (sec)','{\itx_q(k)}')
set(gca,'Xtick',xticks)
set(gca,'XTickLabel',xticklabels)
text (1,1.7,'{\itT} = 0.25')
text (1,1.4,'{\itq} = 0.1290')
text (1,1.1,'{\itN} = 5 bits')
f_wait

