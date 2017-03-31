function fig1_7

% FIGURE 1.7:  Signal types

clc
clear
fprintf ('Figure 1.7: Signal types\n\n')
f = inline ('10*t.*exp(-t)','t');
p = 101;
tau = 4;
t = linspace(0,tau,p);
x_a = f(t);

% Continuous time

figure
plot(t,x_a,'LineWidth',1.5)
f_labels ('{\itx_a(t) = 10t} exp{\it(-t)}','{\itt} (sec)','{\itx_a(t)}')
f_wait
