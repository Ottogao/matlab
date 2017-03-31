function fig5_1

% FIGURE 5.1:  Lowpass fitler specifications 

clc
clear
fprintf ('Figure 5.1:  Lowpass filter specifications\n\n')

% Compute filter coefficients

fs = 1;
F_p = 0.15
F_s = 0.25
delta_p = 0.08
delta_s = delta_p
ftype = 0;
[b,a] = f_cheby1z (F_p,F_s,delta_p,delta_s,ftype,fs);
b = real(b)
a = real(a)
n = length(a)-1

% Compute and plot frequency response

N = 250;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
figure
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
axis ([0 0.5 0 1.2])
hold on
A1 = 1 - delta_p;
A2 = delta_s;
plot ([F_p F_p],[0,1],'k--')
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
plot ([0 F_s],[A2 A2],'k--')
plot ([F_s F_s],[0 A2],'k--')
fill ([F_s 0.5 0.5 F_s],[0 0 A2 A2],'c')
plot (f,A,'LineWidth',1.5)
dx = 0.005;
dy = 0.04;
text (-6*dx,A1,'1-\it{\delta_p}')
text (-4*dx,A2,'\it{\delta_s}')
text (F_p-dx,-dy,'\it{F_p}')
text (F_s-dx,-dy,'\it{F_s}')
text (fs/2-dx,-dy,'\it{f_s/2}')
box on
set (gca,'Xtick',0,'XTickLabel','0')
set (gca,'Ytick',[0 1 1.2],'YTickLabel',[{'0'} {'1'} {'1.2'}])
f_wait
