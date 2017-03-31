function exam3_8

% EXAMPLE 3.8:  Gaussian white noise 

clear
clc
fprintf('Example 3.8: Gaussian white noise\n')
rand ('state',1000)

% Generate signal

N = f_prompt ('Enter number of samples',2,2048,1024);
a = 0;
b = .8;
v = a + b*randn(1,N);
fs = 1000;
f1 = 300;
f2 = 100;
T = 1/fs;
k = 0 : N-1;
x = sin(2*pi*k*f1*T) .* cos(2*pi*k*f2*T) + v;

% Plot signal

figure
plot (0:N/4,x(1:N/4+1))
axis ([0,N/4,-5,5])
f_labels ('Noise-corrupted periodic signal','\it{k}','\it{x(k)}')
f_wait

% Compute average power of noise

P_v = b^2/(2*sqrt(2))

% Compute and plot power density spectrum

A = abs(fft(x));
S_N = A.^2/N;
figure
i = 1 : N/2;
f = (i-1)*fs/N;
plot (f,S_N(i))
axis ([0,N/2,0,80])
f_labels ('Power density spectrum of noise-corrupted periodic signal','{\itf} (Hz)','\it{S_N(f)}')
f_wait
