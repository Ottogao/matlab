function fig1_4

% FIGURE 1.4:  A notch filter

% Initialize

clc
clear
fprintf('Figure 1.4:  A notch filter\n\n')
fs = 1280;
fn = 120;
BW = 4;

% Compute coeffients

r = 1 - pi*BW/fs;
T = 1/fs;
C = cos(2*pi*fn*T);
beta = (r^2 - 2*r*C + 1)/(2 - 2*C);
a = [1 -2*r*C r^2]
b = beta*[1 -2*C 1]
zero = roots(b)
pole = roots(a)

% Find magnitude response

n = 1024;
delta = [1 zeros(1,n-1)];
h = filter(b,a,delta);
A = abs(fft(h));
f = linspace(0,(n-1)*fs/n,n);

% Plot it

figure
plot(f(1:n/2),A(1:n/2),'LineWidth',1.0)
f_labels('Magnitude response','{\itf} (Hz)','{\itA(f)}')
f_wait
