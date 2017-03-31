function fig2_20

% FIGURE 2.20: Region of stable poles

clc
clear
fprintf ('Figure 2.20: Region of stable poles\n\n')

% Draw disk

figure
k = 0 : 500;
n = length(k);
r = ones(size(k));
theta = linspace (0,2*pi,n);
x = r .* cos(theta);
y = r .* sin(theta);
plot (x,y,':k')
hold on
fill (x,y,'c')
axis square
a = 2;
plot ([-a a],[0 0],'k',[0 0],[-a a],'k')
f_labels ('Region of stable poles (shaded)','Re(\it{z})','Im(\it{z})')
f_wait
