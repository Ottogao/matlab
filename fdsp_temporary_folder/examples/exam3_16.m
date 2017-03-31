function exam3_16

% EXAMPLE 3.16: Signal detection 

clear
clc
fprintf('Example 3.16: Signal detection\n')

% Prompt for simulation parameters

seed = f_prompt ('Enter seed for random number generator',0,10000,3000);
M = f_prompt ('Enter number of random sinusoidal terms',0,10,3);
rand ('state',seed);
N = 1024;
k = 0 : N-1;
b = 2;
x = -b + 2*b*rand(1,N);
fs = 2000;
T = 1/fs;
F = (fs/2)*rand(1,M);
for i = 1 : M
   x = x + sin(2*pi*F(i)*k*T);
end   
save u_spectra2 x fs                               % MAT file

% Plot portion of signal

figure
t = k*T;
plot (t(1:N/8),x(1:N/8))
axis([t(1),t(N/8),-5,5])
f_labels ('Noisy time signal with sinusoidal components','{\itt} (sec)','\it{x(t)}')
f_wait

% Compute and plot power density spectrum

figure
A = abs(fft(x));
S_N = A.^2/N;
f = linspace (0,(N-1)*fs/N,N);
plot (f(1:N/2),S_N(1:N/2))
set(gca,'Xlim',[0,fs/2])
f_labels ('Power density spectrum','{\itf} (Hz)','\it{S_N(f)}')

% Find frequencies with user-supplied threshold

S_max = max(S_N);
s = f_prompt ('Enter threshold for locating peaks',0,S_max,.7*S_max);
ipeak = S_N > s;
for i = 1 : N/2
   if ipeak(i) == 1
      fprintf ('f = %.0f Hz\n',f(i))
   end
end
f_wait
 