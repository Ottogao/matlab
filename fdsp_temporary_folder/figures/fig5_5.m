function fig5_5

% FIGURE 5.5:  Basic frequency-selective filters 

clc
clear
fprintf ('Figure 5.5: Basic frequency-selective filters\n')

% Lowpass

figure
subplot(4,1,1)
fs = 2;
F_p = 0.5;
y = 1.6;
plot ([0 F_p F_p fs/2],[1 1 0 0],'k')
axis ([0 fs/2 0 y])
hold on
fill ([0 F_p F_p 0],[0 0 1 1],'c')
dx = 0.01;
dy = 0.24;
text (F_p-dx,-dy,'\it{F_p}')
text (1-2*dx,-dy,'\it{f_s/2}')
set (gca,'Xtick',0)
set (gca,'Ytick',[0 1 y])
text (F_p/2,0.5,'Lowpass','HorizontalAlignment','center')
title ('Ideal frequency-selective filters')

% Highpass

subplot(4,1,2)
F_s = 0.5;
plot ([0 F_s F_s fs/2],[0 0 1 1],'k')
axis ([0 fs/2 0 y])
hold on
fill ([F_s fs/2 fs/2 F_s],[0 0 1 1],'c')
text (F_p-dx,-dy,'\it{F_s}')
text (1-2*dx,-dy,'\it{f_s/2}')
set (gca,'Xtick',0)
set (gca,'Ytick',[0 1 y])
text ((F_s + fs/2)/2,0.5,'Highpass','HorizontalAlignment','center')

% Bandpass

subplot(4,1,3)
Fp = [.25 .75];
plot ([0 Fp(1) Fp(1) Fp(2) Fp(2) fs/2],[0 0 1 1 0 0],'k')
axis ([0 fs/2 0 y])
hold on
fill ([Fp(1) Fp(2) Fp(2) Fp(1)],[0 0 1 1],'c')
text (Fp(1)-1.5*dx,-dy,'\it{F_{p1}}')
text (Fp(2)-1.5*dx,-dy,'\it{F_{p2}}')
text (1-2*dx,-dy,'\it{f_s/2}')
set (gca,'Xtick',0)
set (gca,'Ytick',[0 1 y])
text ((Fp(1)+ Fp(2))/2,0.5,'Bandpass','HorizontalAlignment','center')

% Bandstop

subplot(4,1,4)
Fs = [.25 .75];
plot ([0 Fs(1) Fs(1) Fs(2) Fs(2) fs/2],[1 1 0 0 1 1],'k')
f_labels ('','{\itf }(Hz)','')
axis ([0 fs/2 0 y])
hold on
fill ([0 Fs(1) Fs(1) 0],[0 0 1 1],'c')
fill ([Fs(2) fs/2 fs/2 Fs(2)],[0 0 1 1],'c')
text (Fs(1)-1.5*dx,-dy,'\it{F_{s1}}')
text (Fs(2)-1.5*dx,-dy,'\it{F_{s2}}')
text (1-2*dx,-dy,'\it{f_s/2}')
set (gca,'Xtick',0)
set (gca,'Ytick',[0 1 y])
text (Fs(1)/2,0.5,'Bandstop','HorizontalAlignment','center')
text ((Fs(2) + fs/2)/2,0.5,'Bandstop','HorizontalAlignment','center')
f_wait
