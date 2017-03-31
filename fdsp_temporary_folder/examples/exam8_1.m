function exam8_1

% Example 8.1: Resonator filter

clear
clc
fprintf ('Example 8.1: Resonator filter\n\n')
fs = 1200;
T = 1/fs;
F_0 = 200;
Delta_F = 6;

% Compute filter coefficients

theta_0 = 2*pi*F_0/fs
r = 1 - Delta_F*pi/fs
[b,a] = f_iirres (F_0,Delta_F,fs)

% Construct pole-zero sketch

figure
f_pzplot (b,a);
f_wait

% Plot magnitude response

N = 250;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
figure
plot (f,A,'LineWidth',1.5)
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
f_wait
