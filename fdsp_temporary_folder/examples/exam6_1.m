function exam6_1

% EXAMPLE 6.1:  Truncated impulse response FIR filter 

clear
clc
fprintf('Example 6.1: Truncated impulse response FIR filter\n\n')
fs = 100;
m = f_prompt ('Enter filter order',1,100,40);
win = f_prompt ('Enter filter symmetry (0=even,1=odd)',0,1,0);

% Compute coefficients

F_c = fs/4;
b = f_firwin(@lowpass,m,fs,win,0,F_c);
a = [1,zeros(1,m)];

% Compute pulse response

x = [1,zeros(1,m)];
y = filter(b,a,x);
figure
hp = stem (0:m,y,'Filled','.');
set (hp,'LineWidth',1.5)
f_labels ('Impulse response','\it{k}','\it{h(k)}')
axis ([-5 m+5 -.2 0.6])
f_wait

% Compute and display frequency response

N = 1024;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
phi = angle(H);
figure
subplot (2,1,1)
plot (f,A,'LineWidth',1.5);
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
axis ([0 fs/2 -.2 1.2])
hold on
plot ([0 fs/2],[0 0],'k')
plot ([0 fs/4 fs/4 fs/2],[1 1 0 0],'r')
subplot (2,1,2)
plot (f,phi,'LineWidth',1.5);
f_labels ('Phase response','{\itf} (Hz)','\it{\phi(f)}')
hold on
plot ([0 fs/2],[-pi -pi],'k--')
plot ([0 fs/2],[pi pi],'k--')
text (-0.02*fs,-pi,'-\pi')
text (-0.015*fs,pi,'\pi')
f_wait

function A = lowpass (f,fs,p)

% LOWPASS: Amplitude response of lowpass filter  

A = zeros(size(f));
i = find (f < p);
A(i) = 1;
