function fig5_15

% FIGURE 5.15: Pole-zero plots of four filters with identical A(f) 

clear
clc
fprintf('Figure 5.15: Pole-zero plots of four filters with identical A(f)\n\n')

x1 = 0.5;
y1 = 0.5;
z1 = -0.5;
z2 = 0.5;
r = 1;
c = .15;
phi = linspace(0,2*pi,361);
x = r*cos(phi);
y = r*sin(phi);

% Filter 1

figure
subplot(2,2,1)
box off
d = 3.0;
plot(x,y,'b',[-d d],[0 0],'k',[0 0],[-d d],'k')
axis ([-d d -d d]);
axis square
fsize = 8;
f_labels ('\it{H_{00}(z)}','Re(\it{z})','Im(\it{z})')
text (x1-c,y1,'X','FontSize',fsize)
text (x1-c,-y1,'X','FontSize',fsize)
text (-c+z1,0,'O','FontSize',fsize)
text (-c+z2,0,'O','FontSize',fsize)

% Filter 2

subplot(2,2,2)
box off
plot(x,y,'b',[-d d],[0 0],'k',[0 0],[-d d],'k')
axis ([-d d -d d]);
axis square
set(gca,'XTick',[-3 0 3])
set(gca,'YTick',[-3 0 3])
f_labels ('\it{H_{10}(z)}','Re(\it{z})','Im(\it{z})')
text (x1-c,y1,'X','FontSize',fsize)
text (x1-c,-y1,'X','FontSize',fsize)
text (-c+1/z1,0,'O','FontSize',fsize)
text (-c+z2,0,'O','FontSize',fsize)

% Filter 3

subplot(2,2,3)
box off
plot(x,y,'b',[-d d],[0 0],'k',[0 0],[-d d],'k')
axis ([-d d -d d]);
axis square
set(gca,'XTick',[-3 0 3])
set(gca,'YTick',[-3 0 3])
f_labels ('\it{H_{01}(z)}','Re(\it{z})','Im(\it{z})')
text (x1-c,y1,'X','FontSize',fsize)
text (x1-c,-y1,'X','FontSize',fsize)
text (-c+z1,0,'O','FontSize',fsize)
text (-c+1/z2,0,'O','FontSize',fsize)

% Filter 4

subplot(2,2,4)
box off
plot(x,y,'b',[-d d],[0 0],'k',[0 0],[-d d],'k')
axis ([-d d -d d]);
axis square
set(gca,'XTick',[-3 0 3])
set(gca,'YTick',[-3 0 3])
f_labels ('\it{H_{11}(z)}','Re(\it{z})','Im(\it{z})')
text (x1-c,y1,'X','FontSize',fsize)
text (x1-c,-y1,'X','FontSize',fsize)
text (-c+1/z1,0,'O','FontSize',fsize)
text (-c+1/z2,0,'O','FontSize',fsize)
f_wait
