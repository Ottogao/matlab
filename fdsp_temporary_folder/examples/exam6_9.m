function exam6_9

% EXAMPLE 6.9:  Differentiator 

clear
clc
fprintf('Example 6.9: Differentiator\n\n')
fs = 1;
T = 1/fs;
sym = 1;
m = f_prompt ('Enter fitler order',1,100,11);
win = f_prompt ('Enter window type',0,3,0);

% Compute filter coefficients

fun = @differentiator;
a = [1,zeros(1,m)];
b = f_firwin(fun,m,fs,win,sym);

% Compute magnitude response

p = 1024;
[H,f] = f_freqz (b,a,p,fs);
A = abs(H);
figure
subplot(2,1,1)
hp = plot ([0 .5],[0,pi],'k',f,A);
set (hp(2),'LineWidth',1.5);
f_labels ('Magnitude response','\it{f/f_s}','\it{A(f)}')
legend ('Ideal','FIR filter',0)
subplot(2,1,2)
hp = stem (0:m,b,'filled','.');
set (hp,'LineWidth',1.5)
f_labels ('Impulse response','\it{k}','\it{h(k)}')
axis([-2 m+2 -1.5 1.5])
f_wait

function A = differentiator (f,fs)

% DIFFERENTIATOR: Amplitude response of differentiator 

A = 2*pi*f/fs;
