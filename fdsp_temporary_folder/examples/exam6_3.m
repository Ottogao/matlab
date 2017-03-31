function exam6_3

% EXAMPLE 6.3:  Windowed bandpass filter 

clear
clc
fprintf('Example 6.3: Windowed bandpass filter\n\n')
fs = 1;
F_0 = fs/8;
F_1 = 3*fs/8;
p = 40;
win = f_prompt('Enter window type',0,3,3);
sym = f_prompt('Enter symmetry type (0=even,1=odd)',0,1,0);

% Compute filter coefficients

b = f_firwin (@bandpass,p,fs,win,sym);
a = [1,zeros(1,2*p)];

% Compute magnitude response

range = [0 .5 -120 20];
N = 256;
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
figure
plot (f,A,'LineWidth',1.5);
f_labels ('Magnitude response','\it{f/f_s}','\it{A(f)}')
hold on
B = bandpass(f,fs);
plot (f,B,'k')
f_wait

function A = bandpass (f,fs,p)

% BANDPASS: Amplitude response of bandpass filter 

A = zeros(size(f));
i = find ((f >= fs/8) & (f <= 3*fs/8));
A(i) = 1;
