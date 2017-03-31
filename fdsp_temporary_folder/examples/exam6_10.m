function exam6_10

% EXAMPLE 6.10: Hilbert transformer 

clear
clc
fprintf('Example 6.10: Hilbert transformer\n\n')
fs = 1;
T = 1/fs;
sym = 1;
m = f_prompt ('Enter fitler order',1,100,30);
win = f_prompt ('Enter window type',0,3,2);

% Compute filter coefficients

a = [1,zeros(1,m)];
b = f_firwin(@Hilbert,m,fs,win,sym);

% Compute magnitude response

p = 1024;
[H,f] = f_freqz (b,a,p,fs);
A = abs(H);
figure
subplot(2,1,1)
h = plot ([0 .5],[1 1],'k',f,A);
set (h(2),'LineWidth',1.5)
f_labels ('Magnitude response','\it{f/f_s}','\it{A(f)}')
legend ('Ideal','FIR filter',0)
subplot(2,1,2)
hp = stem (0:m,b,'filled','.');
set (hp,'LineWidth',1.5)
f_labels ('Impulse response','\it{k}','\it{h(k)}')
axis([-5 m+5 -1.5 1.5])
f_wait

function A = Hilbert (f,fs)

% HILBERT: Amplitude response of Hilbert transformer filter  

A = -sign(f);

