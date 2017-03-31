function fig2_4

% FIGURE 2.4:  Z-transform of unit step

clc
clear
fprintf ('Figure 2.4: Z-transform of unit step\n\n')

% Plot x(k)

figure
subplot(1,2,1)
n = 8;
k0 = -n/2 : 2*n;
m = length(k0);
for k = 0 : m-1
   if (k < n/2)
      x(k+1) = 0;
   else
      x(k+1) = 1;
   end
end
h = stem (k0,x,'filled','.');
set (h,'LineWidth',1.5)
f_labels ('Unit step','\it{k}','\it{x(k)}')
axis square
axis([k0(1) k0(m) -.5 1.5])

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
text (1-c,0,'X')
text (-c,0,'O')
f_wait
