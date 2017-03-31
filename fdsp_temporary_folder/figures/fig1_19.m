function fig1_19

% FIGURE 1.19: Common samples of two bandlimited signals

clc
clear
fprintf ('Figure 1.19: Common samples of two bandlimited signals\n\n')
fs = 100;
T = 1/fs;
fn = fs/2;
f0 = 90;
f1 = 10;

% Plot two signals

figure
p = 501;
t = linspace (0,10*T,p);
xa = sin(2*pi*f0*t);
xb = -sin(2*pi*f1*t);
r = plot(t,xa,t,xb);
set (r(2),'LineWidth',1.5)
axis ([0 t(p) -2 2])

% Add samples

hold on
tau = [0 : T : t(p)];
ya = -sin(2*pi*f1*tau);
plot(tau,ya,'ro','LineWidth',1.5)
f_labels ('','{\itt} (sec)','{\itx(t)}')
title ('Common samples')
legend ('{\itx_a}','{\itx_b}')
f_wait
