function fig8_4

% Figure 8.4: Bandpass filter 

clc
clear
fprintf ('Figure 8.4: Bandpass filter\n')

% Plot magnitude response

figure
fs = 2;
y = 2.0;
dy = 0.08;
F = [.25 .75];
plot ([0 F(1) F(1) F(2) F(2) fs/2],[0 0 1 1 0 0],'k')
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
axis ([0 fs/2 0 y])
hold on
fill ([F(1) F(2) F(2) F(1)],[0 0 1 1],'c')
text (F(1),-dy,'\it{F_0}','HorizontalAlignment','center')
text (F(2),-dy,'\it{F_1}','HorizontalAlignment','center')
text (1,-dy,'\it{f_s/2}','HorizontalAlignment','center')
set (gca,'Xtick',0)
set (gca,'Ytick',[0 1 y])
f_wait
