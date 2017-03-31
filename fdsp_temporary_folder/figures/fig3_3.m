function fig3_3

% FIGURE 3.3:  Frequency response 

clear
clc
fprintf('Figure 3.3: Frequency response\n\n')
fs = 100;
N = 256;
a = [1 -0.2 -.63];
b = [10 20 -5];

% Find magnitude response and phase response with FFT

[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
phi = angle(H);

% Plot it

figure
subplot(2,1,1)
plot(f,A,'LineWidth',1.5)
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
subplot(2,1,2)
plot(f,phi,'LineWidth',1.5)
f_labels ('Phase response','{\itf} (Hz)','{\it\phi(f)} (deg)')
f_wait
