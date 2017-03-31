function fig5_3

% FIGURE 5.3:  Cascade filter structure 

clc
clear
fprintf ('Figure 5.3: Cascade filter structure\n\n')

% Compute direct filter coefficients

fs = 1;
F_p = 0.15
F_s = 0.25
delta_p = 0.08
delta_s = delta_p
ftype = 0;
[b,a] = f_cheby1z (F_p,F_s,delta_p,delta_s,ftype,fs);
b = real(b)
a = real(a)
n = length(a)-1

% Compute cascade filter coefficients

[B,A,b_0] = f_cascade (b,a)
f_wait
