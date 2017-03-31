function exam4_13

% EXAMPLE 4.13: Echo detection 

clear
clc
fprintf('Example 4.13: Echo detection\n')
rand('state',1000)

% Construct chirp signal y and its power density spectrum

M = 512;
fs = 1.e7;
T = 1/fs;
f0 = fs/8;
f1 = fs/4;
m = 0 : M-1;
freq = f0 + (f1-f0)*m/(M-1);
y = sin(2*pi*freq.*m*T);
[A,phi,S,f] = f_spec (y,M,fs);
figure
i = 1 : M/2+1;
plot (f(i),S(i))
f_labels ('Power density spectrum of chirp signal','{\itf} (Hz)','\it{S_N(f)}')
f_wait

% Construct received signal x

L = 2048;
a = 0.03;
d = 1304;
x = f_randu(1,L,-0.1,0.1);
x(d+1:d+M) = x(d+1:d+M) + a*y;
k = 0 : L-1;
figure
plot (k,x)
f_labels ('Received signal','\it{k}','\it{x(k)}')
f_wait

% Locate echo and compute range

rho = f_corr (x,y,0,1);
figure
plot (k,rho)
f_labels ('Normalized linear cross-correlation','\it{k}','\it{\rho_{xy}(k)}')
[rmax,kmax] = max(rho)
delay = kmax - 1
c = 1.86e5;
r = c*delay*T/2
precision = c*T/2
f_wait
