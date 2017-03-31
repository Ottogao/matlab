function fig1_23

% FIGURE 1.23: Impulse response of zero-order hold

clc
clear
fprintf ('Figure 1.23: Impulse respose of zero-order hold\n\n')

% Plot impulse response)

figure
hold on
t = [ 0 1 1 2 3 4];
h_a = [1 1 0 0 0 0];
plot(t,h_a,'LineWidth',1.5)
axis([0 4 0 1.5])
f_labels ('Zero-order hold ','{\itt/T}','{\ith_a(t)}')
box on
f_wait
