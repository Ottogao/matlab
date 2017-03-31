function exam3_11

% EXAMPLE 3.11: Spectral resolution 

clear
clc
fprintf('Example 3.11: Spectral resolution\n')

% Construct signal

N = 1024;
k = 0 : N-1;
f_a = 330;
f_b = 331;
f_s = 1024;
T = 1/f_s;
x = sin(2*pi*f_a*k*T) + cos(2*pi*f_b*k*T);
M = 2*N;

% Compute power density spectra and find spectral peaks

S_N = abs(fft(x)).^2/N;
S_M = (M/N)*abs(fft(x,M)).^2/M;                % zero padded
Delta_fN = f_s/N;
Delta_fM = f_s/M;
 
% Plot spectra

figure
f1 = linspace(0,(N-1)*f_s/N,N);
i1 = 1 : N/2;
c = 150;
hp = plot (f1(i1),S_N(i1),'.-',[f_a,f_a],[0,c],'k',[f_b,f_b],[0,c],'k');
set (hp(1),'LineWidth',1.5)
axis ([320 340 0 300])
title = sprintf (['Power density spectrum: {\\itf_a} = %.1f Hz,',...
      ' {\\itf_b} = %.1f Hz'],f_a,f_b);
f_labels (title,'{\itf} (Hz)','\it{S_N(f)}')
f_wait

figure
f2 = linspace(0,(M-1)*f_s/M,M);
i2 = 1 : M/2;
hp = plot (f2(i2),S_M(i2),'.-',[f_a,f_a],[0,c],'k',[f_b,f_b],[0,c],'k');
set (hp(1),'LineWidth',1.5)
axis ([320 340 0 300])
title = sprintf (['Power density spectrum with zero padding: {\\itf_a} = %1.f Hz,'...
      ' {\\itf_b} = %.1f'],f_a,f_b);
f_labels (title,'{\itf} (Hz)','\it{S_M(f)}')
f_wait

% Add samples to improve frequency resolution

N = 2*N;
k = 0 : N-1;
f_s = 1024;
x = sin(2*pi*f_a*k*T) + cos(2*pi*f_b*k*T);

% Compute power density spectra and find spectral peaks

c = 250;
S_N = abs(fft(x)).^2/N;
Delta_fN = f_s/N;
figure
f1 = linspace(0,(N-1)*f_s/N,N);
i1 = 1 : N/2;
hp = plot (f1(i1),S_N(i1),'.-',[f_a,f_a],[0,c],'k',[f_b,f_b],[0,c],'k');
set (hp(1),'LineWidth',1.5)
axis ([320 340 0 600])
title = sprintf (['Power density spectrum with more samples: {\\itf_a} = %1.f Hz,'...
      ' {\\itf_b} = %.1f'],f_a,f_b);
f_labels (title,'{\itf} (Hz)','\it{S_N(f)}')
f_wait
