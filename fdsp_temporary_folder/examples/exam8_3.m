function exam8_3

% Example 8.3: Filter design parameters  

clc
clear
fprintf ('Figure 8.3: Filter design parameters\n\n')

% Get specifications

F_p = f_prompt ('Enter passband cutoff freqeuncy',0,1000,400);
F_s = f_prompt ('Enter stopband cutoff freqeuncy',F_p,1000,F_p+100);
A_p = f_prompt ('Enter passband ripple in dB',0,3,0.5);
A_s = f_prompt ('Enter stopband attenuation in dB',0,120,35);

% Compute design parameters

delta_p = 1 - 10^(-A_p/20)
delta_s = 10^(-A_s/20)
r = F_p/F_s
d = sqrt(((1-delta_p)^(-2)-1)/(delta_s^(-2)-1))
f_wait
