function fig1_11

% FIGURE 1.11: Unit impluse and unit step

clc
clear
fprintf ('Figure 1.11: Unit impulse and unit step\n\n')
c = 2;
h = 0.04;

% Sketch impulse

figure
plot ([-c c],[0 0],'LineWidth',1.5)
axis ([-2 2 -0.5 1.5])
hold on
plot ([0 0],[0 1-h],'LineWidth',1.5)
plot ([-h h 0 -h],[1-h 1-h 1 1-h],'LineWidth',1.5)
axis ([-2 2 -0.5 1.5])
f_labels ('Elementary signals','{\itt }(sec)','{\itx_a(t)}')

% Sketch step

plot([0 c],[1 1],'g--','LineWidth',1.5)
text (1.,1.1,'{\itu_a(t)}')
text (-0.3,0.5,'{\it\delta_a(t)}')
f_wait
