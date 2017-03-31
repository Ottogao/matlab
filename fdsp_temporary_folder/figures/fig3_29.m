function fig3_29

% FIGURE 3.29: Window functions

clc
clear
fprintf ('Figure 3.29: Window functions\n\n')

% Compute windows

L = 256;
k = 0 : L;
win = 4;
w = zeros(win,L+1);
for i = 1 : win
   w(i,1:L+1) = f_window (i-1,L);
end

% Plot them

figure
plot (k,w,'LineWidth',1.5)
axis([0,L,0,1.2])
hold on
plot ([L/2 L/2],[0 1.2],'k--')
f_labels ('Window functions','\it{k}','\it{w(k)}')
text (50,1.03,'0')
text (45,.25,'1')
text (5,.12,'2')
text (73,.40,'3')
f_wait
 