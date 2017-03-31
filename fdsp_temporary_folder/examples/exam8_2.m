function exam8_2

% Example 8.2: Notch filter 

clear
clc
fprintf ('Example 8.2: Notch filter\n\n')
fs = 2400;
T = 1/fs;
F_0 = 800;
Delta_F = 18;
 
% Compute filter coefficients

theta_0 = 2*pi*F_0/fs
r = 1 - Delta_F*pi/fs
[b,a] = f_iirnotch (F_0,Delta_F,fs)

% Construct pole-zero sketch

figure
f_pzplot (b,a);
f_wait

% Plot magnitude response

N = 240;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
figure
plot (f,A,'LineWidth',1.5)
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
f_wait
