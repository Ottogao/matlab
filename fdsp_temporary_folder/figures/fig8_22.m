function fig8_22

% Figure 8.22: Freqeuncy warping 

clear
clc
fprintf ('Figure 8.22: Frequency warping\n\n')

% Compute curve and plot it

T = 1;
m = 100;
n = m-3;
f = linspace (0,(m-1)*0.5/m,m);
F = tan(pi*f*T)/(pi*T);
figure
plot (f(1:n),F(1:n),'LineWidth',1.5)
f_labels ('Freqeuncy warping','\it{f/f_s}','{\itF} (Hz)')
f_wait
 