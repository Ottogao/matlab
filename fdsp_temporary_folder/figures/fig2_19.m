function fig2_19

% FIGURE 2.19: A bounded signal

clc
clear
fprintf ('Figure 2.19: A bounded signal\n\n')

% Draw strip

figure
k = 0 : 100;
n = length(k);
b = ones(size(k));
x = f_randu(1,n,-b(1),b(1));
fill ([k(1) k(n) k(n) k(1)],[-1 -1 1 1],'c')
hold on
plot(k,b,'b',k,-b,'b',k,zeros(1,n),'k',k,x)
axis ([k(1) k(n) -2*b(1) 2*b(1)])
f_labels ('Bounded random signal','\it{k}','\it{x(k)}')
text (-4,b(1),'\it{B_x}')
text (-5,-b(1),'\it{-B_x}')
set (gca,'YTickLabel','')
set (gca,'XTick',[k(1) k(n)])
set (gca,'XtickLabel','')
set (gca,'YTick',[-2*b(1) 2*b(1)])
f_wait
