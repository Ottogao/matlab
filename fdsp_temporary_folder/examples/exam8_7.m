function exam8_7

% Example 8.7: Elliptic filter design 

clear
clc
fprintf('Example 8.7: Elliptic filter design\n\n')
F_p = 1000;
F_s = 2000;
delta_p = 0.05;
delta_s = 0.05;

% Compute filter order

r = F_p/F_s
d = sqrt(((1-delta_p)^(-2)-1)/(delta_s^(-2)-1))
d1 = ellipke(r^2)*ellipke(sqrt(1-d^2));
d2 = ellipke(1-r^2)*ellipke(d^2);
n = d1/d2
n = ceil(n)
 
% Equivalent logarithmic specifications

A_p = -20*log10(1 - delta_p);
A_s = -20*log10(delta_s);    
f_wait
