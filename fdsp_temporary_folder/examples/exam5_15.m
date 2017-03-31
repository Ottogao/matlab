function exam5_15

% EXAMPLE 5.15: IIR scaling to prevent overflow 

clear
clc
fprintf('Example 5.15: IIR scaling to prevent overflow\n')
x_M = 5;
b_0 = 4;
p = 0.8;

% L_1 norm

h_1 = b_0/(1 - p)
s_1 = 1/h_1

% L_2 norm

h_22 = b_0^2/(1 - p^2)
s_2 = 1/sqrt(h_22)

% L_infinity norm

a = [1 -p];
[H,f] = f_freqz(b_0,a,100,1);
A = abs(H);
h_infty = max(A)
s_infty = 1/h_infty
figure
plot(f,A,'LineWidth',1.5)
f_labels ('Magnitude response','\it{f/f_s}','\it{A(f)}')
f_wait
