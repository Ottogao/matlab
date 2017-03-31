function fig6_8

% FIGURE 6.8:  Data windows

clc
clear
fprintf ('Figure 6.8: Data windows\n\n')

% Compute windows

p = 30;
k = 0 : 2*p;
r = 2*p;
win = 4;
w = zeros(win,r+1);
for i = 1 : win
   w(i,1:r+1) = f_window (i-1,r);
end

% Plot them

figure
plot (k,w,'LineWidth',1.5)
axis([0,2*p,0,1.2])
f_labels ('Windows','\it{i}','\it{w(i)}')
text (12,1.03,'0')
text (10.75,.25,'1')
text (1,.12,'2')
text (16.7,.40,'3')
hold on
plot ([p p],[0 1.2],'k--')
f_wait
 