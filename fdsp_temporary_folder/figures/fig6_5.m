function fig6_5

% FIGURE 6.5:  Lowpass FIR fitler specifications (linear)

clc
clear
fprintf ('Figure 6.5: Lowpass FIR filter specifications (linear)\n\n')

% Draw lines

delta_p = 0.06;
delta_s = delta_p;
F_p = 0.45;
F_s = 0.55;
figure
plot ([0 F_p],[1 1],'k')
hold on
plot ([0 F_p],[1-delta_p 1-delta_p],'k')
plot ([0 F_p],[1+delta_p 1+delta_p],'k')
axis ([0 1 -delta_s 1.2])
plot ([F_p F_p],[-delta_s 1+delta_p],'--k')
plot ([0 F_s],[delta_s delta_s],'--k')
plot ([F_s F_s],[-delta_s delta_s],'--k')
plot ([F_s 1],[delta_s delta_s],'k')
fill ([0 F_p F_p 0],[1-delta_p 1-delta_p 1+delta_p 1+delta_p],'c')
fill ([F_s 1 1 F_s],[-delta_s -delta_s delta_s delta_s],'c')
plot ([0 F_p],[1 1],'k')
plot ([0 1],[0 0],'k')

% Add labels

dx = 0.01;
dy = 0.04;
text (-0.03,1,'1')
text (-0.07,1-delta_p,'1-\delta_p')
text (-0.07,1+delta_p,'1+\delta_p')
text (-0.04,delta_s,'\delta_s')
text (-0.03,0,'0')
text (-0.05,-delta_s,'-\delta_s')
text (0-0.5*dx,-delta_s-dy,'0')
text (F_p-dx,-delta_s-dy,'\it{F_p}')
text (F_s-dx,-delta_s-dy,'\it{F_s}')
text (1-2*dx,-delta_s-dy,'\it{f_s/2}')
text (F_p/2-6*dx,1+delta_p+dy,'Passband')
text ((F_s+ 1)/2-6*dx,delta_s+dy,'Stopband')
set (gca,'Xtick',[])
set (gca,'Ytick',[])
text (0.5-dx,-4*dy,'\it{f}')
text (-8*dx,0.5-dy/2,'\it{A_r(f)}','Rotation',90)
title ('Amplitude response specification')
f_wait
