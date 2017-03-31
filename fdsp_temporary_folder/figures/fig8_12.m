function fig8_12

% Figure 8.12: Poles and zeros of an inverse comb filter 

clear
clc
fprintf ('Figure 8.12: Poles and zeros of an inverse comb filter\n\n')
n = f_prompt('Enter filter order',2,41,11);
fs = f_prompt ('Enter sampling freqeuncy',1,1000000,2200);
F_0 = fs/n;
Delta_F = f_prompt ('Enter 3 dB radius',0,F_0/2,F_0/20);

% Compute filter coefficients

r = 1 - (Delta_F*pi)/fs
b0 = (1 + r^n)/2
[b,a] = f_iirinv (n,Delta_F,fs)

% Construct pole-zero sketch

figure
f_pzplot (b,a);
f_wait
