function fig5_11

% Figure 5.11: Lowpass filter specifications (logarithmic) 

clc
clear
fprintf ('Figure 5.11: Lowpass filter specifications (logarithmic)\n\n')

% Draw lines

A_p = 0.15;
A_s = 0.9;
F_p = 0.45;
F_s = 0.55;
figure
plot ([0 F_p],[-A_p -A_p],'k')
axis ([0 1 -1.2 0])
hold on
plot ([F_p F_p],[-A_p 0],'--k')
plot ([0 F_s],[-A_s -A_s],'--k')
plot ([F_p F_p],[-1.2 0],'--k')
plot ([1 1],[-1.2 0],'--k')
plot ([F_s 1],[-A_s -A_s],'k')
fill ([0 F_p F_p 0],[-A_p -A_p 0 0],'c')
fill ([F_s 1 1 F_s],[-1.2 -1.2 -A_s -A_s],'c')

% Add labels

dx = 0.01;
dy = 0.035;
y1 = -1.24;
text (-0.03,0,'0')
text (-0.05,-A_p,'\it{-A_p}')
text (-0.05,-A_s,'\it{-A_s}')
text (0-dx,y1,'0')
text (F_p-dx,y1,'\it{F_p}')
text (F_s-dx,y1,'\it{F_s}')
text (1-2*dx,y1,'\it{f_s/2}')
text (F_p/2-6*dx,-A_p-dy,'Passband')
text ((F_s+ 1)/2-6*dx,-A_s+dy,'Stopband')
set (gca,'Xtick',[])
set (gca,'Ytick',[])
text (0.5-dx,y1-2.5*dy,'{\itf }(Hz)','FontSize',11)
text (-9*dx,-0.6,'{\itA(f)} dB','Rotation',90,'FontSize',11)
f_labels ('Logarithmic filter specifications','','')
f_wait
