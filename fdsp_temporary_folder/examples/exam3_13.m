function exam3_13

% EXAMPLE 3.13: Bartlett's method: periodic input 

clear
clc
fprintf('Example 3.13: Bartlett''s method: periodic input\n')
rand ('state',1000)

% Construct signal

N = 512;
k = 0 : N-1;
f_a = 200;
f_b = 331;
f_s = 1024;
T = 1/f_s;
x = sin(2*pi*f_a*k*T) - sqrt(2)*cos(2*pi*f_b*k*T);
L = 128;

% Compute average periodogram

fs = 1;
[S_B,f,P_x] = f_pds (x,N,L,fs,0,0);
peak1 = S_B(26)
peak2 = max(S_B)

% Plot average periodogram

figure
f = linspace(0,(L-1)*f_s/L,L);
i = 1 : L/2;
hp = plot (f(i),S_B(i),[f_a,f_a],[0,18],'k',[f_b,f_b],[0,18],'k');
set (hp(1),'LineWidth',1.5)
axis ([0,f_s/2,0,40])
title = sprintf ('Average periodogram: {\\itf_a} = 200 Hz, {\\itf_b} = 331 Hz, {\\it\\Delta f} = 8 Hz');
f_labels (title,'{\itf} (Hz)','\it{S_B(f)}')
f_wait
