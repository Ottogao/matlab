function fig2_5

% FIGURE 2.5:  Z-transform of causal exponentials

clc
clear
fprintf ('Figure 2.5: Z-transform of causal exponentials\n')

% Stable a

figure
n = 8;
k0 = -n/4 : 2*n;
m = length(k0);
subplot(2,2,1)
a = 0.8;
for k = 0 : m-1;
   if (k < n/2)
      x(k+1) = 0;
   else
      x(k+1) = a^(k-n/2);
   end
end
h = stem (k0,x,'filled','.');
set (h,'LineWidth',1.5)
f_labels ('Causal exponentials','\it{k}','\it{x(k)}')
axis square
axis([k0(1) k0(m) -0.2 1.2])

% Pole-zero pattern

c=0.085;
r = 1;
phi = linspace(0,2*pi,361);
x1 = r*cos(phi);
y1 = r*sin(phi);
subplot(2,2,2)
box off
h = plot(x1,y1,'b',[-2 2],[0 0],'k',[0 0],[-2 2],'k');
set(h(1),'LineWidth',1.5)
axis square
f_labels ('Pole-zero patterns','Re(\it{z})','Im(\it{z})')
text (a-c,0,'X')
text (-c,0,'O')

% Unstable a

subplot(2,2,3)
a = 1.1;
for k = 0 : m-1;
   if (k < n/2)
      x(k+1) = 0;
   else
      x(k+1) = a^(k-n/2);
   end
end
h = stem (k0,x,'filled','.');
set (h,'LineWidth',1.5)
f_labels ('','\it{k}','{\itx(k)}')
axis square
axis([k0(1) k0(m) -0.5 5])

% Pole-zero pattern

c=0.085;
subplot(2,2,4)
box off
h = plot(x1,y1,'b',[-2 2],[0 0],'k',[0 0],[-2 2],'k');
set (h(1),'LineWidth',1.5)
axis square
f_labels ('','Re(\it{z})','Im(\it{z})')
text (a-c,0,'X')
text (-c,0,'O')
f_wait
