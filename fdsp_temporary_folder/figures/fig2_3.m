function fig2_3

% FIGURE 2.3:  Typical region of convergence (ROC)

clc
clear
fprintf ('Figure 2.3: Typical region of convergence (ROC)\n\n')

% Plot ROC

figure
r = 1.5;
phi = linspace(0,2*pi,361);
x = r*cos(phi);
y = r*sin(phi);
box off
c = 3;
plot (x,y,':k')
hold on
fill ([-c c c -c],[-c -c c c],'c')
fill (x,y,'w')
plot (x,y,':k')
plot([-c c],[0 0],'k',[0 0],[-c c],'k')
axis square
text (1.6,-0.2,'\it{R_x}')
text (-1.9,1.7,'ROC')
f_labels ('Region of convergence (shaded)','Re(\it{z})','Im(\it{z})')
set (gca,'XtickLabel','','YtickLabel','')
f_wait

