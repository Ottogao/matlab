function fig2_6

% FIGURE 2.6:  Z-transform of exponentially dampled sine

clc
clear
fprintf ('Figure 2.6: Z-transform of exponentially dampled sine\n\n')

% Plot x(k)

figure
n = 8;
k0 = -n/4 : 2*n;
m = length(k0);
subplot(1,2,1)
a = 0.85;
b = 0.4;
for k = 0 : m-1;
   if (k < n/2)
      x(k+1) = 0;
   else
      x(k+1) = a^(k-n/2)*sin(b*(k-n/2));
   end
end
h = stem (k0,x,'filled','.');
set (h,'LineWidth',1.5)
f_labels ('Exponentially damped sine','\it{k}','\it{x(k)}')
axis square
axis([k0(1) k0(m) -0.5 1.2])

% Pole-zero pattern

c = 0.085;
r = 1;
phi = linspace(0,2*pi,361);
x = r*cos(phi);
y = r*sin(phi);
subplot(1,2,2)
box off
h = plot(x,y,'b',[-2 2],[0 0],'k',[0 0],[-2 2],'k');
set (h(1),'LineWidth',1.5)
axis square
f_labels ('Pole-zero pattern','Re(\it{z})','Im(\it{z})')
x1 = a*cos(b);
y1 = a*sin(b);
text (x1-c,y1,'X')
text (x1-c,-y1,'X')
text (-c,0,'O')
f_wait
