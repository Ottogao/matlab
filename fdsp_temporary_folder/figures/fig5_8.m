function fig5_8

% FIGURE 5.8:  Bandpass filter specifications (linear) 

clc
clear
fprintf ('Figure 5.8: Bandpass filter specifications (linear)\n\n')

% Draw lines

delta_p = 0.1;
delta_s = 0.1;
F_s1 = 0.25;
F_p1 = 0.35;
F_p2 = 0.65;
F_s2 = 0.75;
figure
plot ([0 F_p1],[1 1],'--k',[0 F_p1],[1-delta_p 1-delta_p],'--k')
axis ([0 1 0 1.2])
hold on
plot ([F_p1 F_p1],[0 1],'--k')
plot ([F_p2 F_p2],[0 1],'--k')
plot ([F_p1 F_p2],[1 1],'k',[F_p1 F_p2],[1-delta_p 1-delta_p],'k')
plot ([F_s1 F_s1],[0 delta_s],'--k')
plot ([F_s2 F_s2],[0 delta_s],'--k')
plot ([1 1],[0 1-delta_p],'--k')
plot ([0 F_s1],[delta_s delta_s],'k')
plot ([F_s2 1],[delta_s delta_s],'k')
plot ([F_s1 F_s2],[delta_s delta_s],'--k')
fill ([F_p1 F_p2 F_p2 F_p1],[1-delta_p 1-delta_p 1 1],'c')
fill ([0 F_s1 F_s1 0],[0 0 delta_s delta_s],'c')
fill ([F_s2 1 1 F_s2],[0 0 delta_s delta_s],'c')

% Add labels

dx = 0.01;
dy = 0.04;
text (-0.03,1,'1')
text (-0.06,1-delta_p,'1-{\it\delta_p}')
text (-0.04,delta_s,'\it{\delta_s}')
text (-0.03,0,'0')
text (0-dx,-dy,'0')
text (F_s1-dx,-dy,'\it{F_{s1}}')
text (F_p1-dx,-dy,'\it{F_{p1}}')
text (F_p2-dx,-dy,'\it{F_{p2}}')
text (F_s2-dx,-dy,'\it{F_{s2}}')
text (1-2*dx,-dy,'\it{f_s/2}')
text (F_s1/2-6*dx,delta_s+dy,'Stopband')
text ((F_s2+1)/2-6*dx,delta_s+dy,'Stopband')
text ((F_p1+F_p2)/2-6*dx,1+dy,'Passband')
set (gca,'Xtick',[])
set (gca,'Ytick',[])
title ('Bandpass specification')
text (0.5-dx,-3*dy,'{\itf }(Hz)','FontSize',11)
text (-8*dx,0.5-dy/2,'\it{A(f)}','Rotation',90,'FontSize',11)
f_wait
