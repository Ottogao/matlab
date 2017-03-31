function exam3_14

% EXAMPLE 3.14: Welch's method: noisy periodic input 

clear
clc
fprintf('Example 3.14: Welch''s method: noisy periodic input\n')
rand ('state',1000)

% Construct signal

N = 1024;
k = 0 : N-1;
f_a = 200;
f_b = 331;
f_s = 1024;
T = 1/f_s;
a = 3;
x = -a + 2*a*rand(1,N);
x = x + sin(2*pi*f_a*k*T) - sqrt(2)*cos(2*pi*f_b*k*T);
L = 256;
M = N/L;
P_u = 2*a^3/(6*a)

% Compute average periodogram

[S_W,f,P_x] = f_pds (x,N,L,f_s,2,1);
[peak1,i1] = max(S_W(1:L/4))
[peak2,i2] = max(S_W(L/4+1:L/2))

% Plot average periodogram

figure
hp = plot (f,S_W,[f_a,f_a],[0,18],'k',[f_b,f_b],[0,18],'k',[0,f_s/2],[P_u,P_u]);
set (hp(1),'LineWidth',1.5)
axis ([0,f_s/2,0,80])
title = sprintf (['Modified average periodogram: {\\itf_a} = 200 Hz, {\\itf_b} = 331 Hz,',...
                  ' {\\it\\Delta f} = 4 Hz, {\\itP_u} = %.1f'],P_u);
f_labels (title,'{\itf} (Hz)','\it{S_W(f)}')
f_wait
