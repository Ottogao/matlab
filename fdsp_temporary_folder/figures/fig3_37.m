function fig3_37

% FIGURE 3.37: Saturation due to clipping

clc
clear
fprintf ('Figure 3.37: Saturation due to clipping\n\n')
 
% Construct clipping function

a = -1;
b = 1;
x = linspace (-2,2,200);
y = f_clip (x,a,b);
 
% Plot it

figure
h = plot (x,y,x,x,'--');
set (h(1),'LineWidth',1.5)
hold on
plot ([-2 2],[0 0],'k',[0 0],[-2 2],'k')
f_labels ('Saturation due to clipping','\it{x}','\it{y}')
hold on
c = 0.05;
plot ([-1 -1],[-c c],'k',[1 1],[-c c],'k')
text (-1.02,-.16,'a')
text (0.98,-.16,'b')
f_wait
 