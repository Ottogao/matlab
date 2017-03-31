function fig2_21

% FIGURE 2.21: Stable parameter region for a second-order system

clc
clear
fprintf ('Figure 2.21: Stable parameter region for a second-order system\n\n')

% Draw triangle

figure
a = 2.5;
b = 1.5;
x = [2 -2 0];
y = [1 1 -1];
plot (x,y,':k')
axis ([-a a -b b])
hold on
fill (x,y,'c')
plot ([-a a],[0 0],'k',[0 0],[-b b],'k')
x1 = linspace(-2,2,100);
y1 = (x1 .^ 2)/4;
plot (x1,y1,'LineWidth',1.5)
f_labels ('Region of stable second-order parameters','\it{a_1}','\it{a_2}')
text (-0.4,-0.3,'Real')
text (.15,-0.3,'poles')
text (-0.75,0.55,'Complex')
text (.28,0.55,'poles')
f_wait
