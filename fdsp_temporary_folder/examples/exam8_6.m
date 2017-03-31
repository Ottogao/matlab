function exam8_6

% Example 8.6: Chebyshev-I filter design 

clear
clc
fprintf('Example 8.6: Chebyshev-I filter design\n\n')
F_p = 1000
F_s = 2000
delta_p = 0.05;
delta_s = 0.05;

% Compute filter order

r = F_p/F_s
d = sqrt(((1 - delta_p)^(-2)-1)/(delta_s^(-2)-1))
n = log(d^(-1)+ sqrt(d^(-2)-1))/log(r^(-1) + sqrt(r^(-2)-1))
n = ceil(n);
 
% Equivalent logarithmic specifications

A_p = -20*log10(1 - delta_p)
A_s = -20*log10(delta_s)    
f_wait
