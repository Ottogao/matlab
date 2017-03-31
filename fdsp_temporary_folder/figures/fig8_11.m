function fig8_11

% Figure 8.11: Magnitude response of a comb filter 

clear
clc
fprintf ('Figure 8.11: Magnitude response of a comb filter\n\n')
n = f_prompt('Enter filter order',2,41,10);
fs = f_prompt ('Enter sampling freqeuncy',1,1000000,200);
F_0 = fs/n;
Delta_F = f_prompt ('Enter 3 dB radius',0,F_0/2,F_0/20);

% Compute filter coefficients

r = 1 - (Delta_F*pi)/fs
b0 = 1 - r^n
[b,a] = f_iircomb (n,Delta_F,fs)
 
% Plot magnitude response

N = 250;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
figure
plot (f,A,'LineWidth',1.5)
axis ([0 100 0 1.2])
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
f_wait
