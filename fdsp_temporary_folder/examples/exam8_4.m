function exam8_4

% Example 8.4: Butterworth filter  

clear
clc
fprintf('Example 8.4: Butterworth filter\n\n')
F_p = 1000
F_s = 2000
delta_p = 0.05;
delta_s = 0.05;

% Compute filter order

r = F_p/F_s
d1 = (1 - delta_p)^(-2) - 1;
d2 = delta_s^(-2) - 1;
d = sqrt(d1/d2)
n = log(d)/log(r)
n = ceil(n);
 
% Compute cutoff frequency

F_cp = F_p/d1^(1/(2*n))
F_cs = F_s/d2^(1/(2*n))
F_c = (F_cp + F_cs)/2

% Equivalent logarithmic specifications

A_p = -20*log10(1 - delta_p)
A_s = -20*log10(delta_s)    
f_wait
