function exam3_10

% EXAMPLE 3.10: Zero padding 

clear
clc
fprintf('Example 3.10: Zero padding\n')

% Construct signal

N = 256;
k = 0 : N-1;
f_a = 330.5;
f_s = 1024;
T = 1/f_s;
x = cos(2*pi*f_a*k*T);
M = 8*N;

% Compute power density spectra and find spectral peaks

S_N = abs(fft(x)).^2/N;
S_M = (M/N)*abs(fft(x,M)).^2/M;                % zero padded
Delta_fN = f_s/N;
Delta_fM = f_s/M;
[peak,i] = max(S_N);
f_N = (i-1)*Delta_fN;
[peak,i] = max(S_M);
f_M = (i-1)*Delta_fM;  
 
% Plot spectra

figure
f1 = linspace(0,(N-1)*f_s/N,N);
i1 = 1 : N/2;
f2 = linspace(0,(M-1)*f_s/M,M);
i2 = 1 : M/2;
hp = plot (f1(i1),S_N(i1),'o',f2(i2),S_M(i2),[f_a,f_a],[0,40],'k');
set (hp(2),'LineWidth',1.5)
legend ('\it{S_N(f)}','\it{S_M(f)}')
axis ([300 360 0 80])
title = sprintf (['Power density spectra: {\\itf_a} = %.1f Hz,',...
      ' {\\it\\Delta f_N} = %.1f Hz, {\\it\\Delta f_M} = %.1f Hz'],f_a,Delta_fN,Delta_fM);
f_labels (title,'{\itf} (Hz)','\it{S_M(f)}')
fpeak = sprintf ('{\\itf_N} = %.1f Hz',f_N);   
text (310,45,fpeak)   
fpeak = sprintf ('{\\itf_M} = %.1f Hz',f_M);   
text (310,40,fpeak)   
f_wait
