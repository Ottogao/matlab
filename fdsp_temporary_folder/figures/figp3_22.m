function figp3_22

% FIGURE p3.22: Noise-corrupted signal (Problem 3.22)

clc
clear
fprintf ('Figure p3.22: Noise-corrupted signal\n\n')
 
% Construct signal

a = -1;
b = 1;
N = 1024;
fs = 2000;
T = 1/fs;
x = a + (b-a)*rand(1,N);
f1 = 250;
f2 = 400;
k = 0 : N-1;
x = x + cos(2*pi*f1*k*T) + sin(2*pi*f2*k*T); 

% Plot it and save it

figure
plot (k(1:N/8),x(1:N/8))
axis([0 N/8 -3 3])
f_labels ('Noise-corrupted signal','\it{k}','\it{x(k)}')
save '..\prob\prob3_22' x fs
f_wait
