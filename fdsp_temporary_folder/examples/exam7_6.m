function exam7_6

% Example 7.6: Multirate narrowband filter 

clear
clc
fprintf('Example 7.6: Multirate narrowband filter\n\n')
n1 = f_prompt ('Enter fixed-rate filter order',0,250,240);
n2 = f_prompt ('Enter multirate filter order',0,80,80);
M = f_prompt ('Enter rate conversion factor',1,32,8);
fs = 1;
win = 3;
p1 = 1/32;
p2 = 1/4;

% Compute fixed-rate design

b1 = f_firideal (0,p1,n1,fs,win);

% Compute multirate design

b2 = f_firideal (0,p2,n2,fs,win);

% Compute magnitude responses

N = 1600;
[H1,f] = f_freqz (b1,1,N,fs);
x = [1, zeros(1,N-1)];
y1 = f_rateconv (x,fs,1,M,n2,win);
y2 = filter (b2,1,y1);
y = f_rateconv (y2,fs,M,1,n2,win);
H2 = fft(y);
f2 = linspace(0,(N-1)*fs/N,N);
F2 = f2(1:N/4);

% Plot them

figure
F = f(1:N/4);
h = plot (F,lowpass(F,fs,p1),'--k',F,abs(H1(1:N/4)),F2,abs(H2(1:N/4)));
set (h(3),'LineWidth',1.5)
axis ([0 fs/8 0 1.2])
f_labels ('Magnitude responses','\it{f/f_s}','\it{A(f)}')
legend ('Ideal','Fixed-rate','Multirate')
f_wait

function A = lowpass (f,fs,p)

% Description: Magnitude response of lowpass filter 

A = zeros(size(f));
i = find (f < p);
A(i) = 1;
 