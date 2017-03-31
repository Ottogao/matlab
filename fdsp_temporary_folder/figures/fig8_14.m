function fig8_14

% Figure 8.14: Lowpass filter design specifications  

clc
clear
fprintf ('Figure 8.14: Lowpass filter desgin specifications\n\n')

% Draw lines

delta_p = 0.1;
delta_s = 0.1;
F_p = 0.45;
F_s = 0.55;
figure
plot ([0 F_p],[1 1],'k',[0 F_p],[1-delta_p 1-delta_p],'k')
axis ([0 1 0 1.2])
hold on
plot ([F_p F_p],[0 1],'--k')
plot ([0 F_s],[delta_s delta_s],'--k')
plot ([F_s F_s],[0 delta_s],'--k')
plot ([F_s 1],[delta_s delta_s],'k')
fill ([0 F_p F_p 0],[1-delta_p 1-delta_p 1 1],'c')
fill ([F_s 1 1 F_s],[0 0 delta_s delta_s],'c')

% Add labels

dx = 0.01;
dy = 0.04;
set (gca,'FontSize',11)
text (-0.03,1,'1')
text (-0.06,1-delta_p,'1-\delta_p')
text (-0.04,delta_s,'\delta_s')
text (-0.03,0,'0')
text (0-dx,-dy,'0')
text (F_p-dx,-dy,'\it{F_p}')
text (F_s-dx,-dy,'\it{F_s}')
text (1-2*dx,-dy,'\it{f_s/2}')
text (F_p/2-6*dx,1+dy,'Passband')
text ((F_s+ 1)/2-6*dx,delta_s+dy,'Stopband')
set (gca,'Xtick',[])
set (gca,'Ytick',[])
text (0.5-dx,-3*dy,'{\itf }(Hz)','FontSize',11)
text (-8*dx,0.5-dy/2,'\it{A(f)}','Rotation',90,'FontSize',11)
f_wait
