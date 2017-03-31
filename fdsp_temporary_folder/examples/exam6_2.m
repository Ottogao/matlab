function exam6_2

% EXAMPLE 6.2:  Windowed lowpass filter 

clear
clc
fprintf('Example 6.2: Windowed lowpass filter\n\n')
fs = 1;
sym = 0;
m = f_prompt ('Enter filter order:',0,80,40);
b = zeros(1,m+1);
a = [1,zeros(1,m)];
range = [0 .5 -120 20];
N = 1001;
eps = [30 50 70 90];
f_type = 0;
F = fs/4;

% Rectangular window

b = f_firideal (f_type,F,m,fs,0);
[H,f] = f_freqz (b,a,N,fs);
A = 20*log10(abs(H));
[A_s,f0] = f_getAs(b,a,fs,eps(1))
figure
hp = plot (f,A,[0 0.5],-[A_s A_s],'k--');
set (hp(1),'LineWidth',1.5)
axis (range);
f_labels ('Lowpass filter using rectangular window','\it{f/f_s}','{\itA(f)} (dB)')
f_wait

% Hanning window

b = f_firideal (f_type,F,m,fs,1);
[H,f] = f_freqz (b,a,N,fs);
A = 20*log10(abs(H));
[A_s,f0] = f_getAs(b,a,fs,eps(2))
figure
hp = plot (f,A,[0 0.5],-[A_s A_s],'k--');
set (hp(1),'LineWidth',1.5)
axis (range);
f_labels ('Lowpass filter using Hanning window','{\itf/f_s}','{\itA(f)} (dB)')
f_wait

% Hamming window

b = f_firideal (f_type,F,m,fs,2);
[H,f] = f_freqz (b,a,N,fs);
A = 20*log10(abs(H));
[A_s,f0] = f_getAs(b,a,fs,eps(3))
figure
hp = plot (f,A,[0 0.5],-[A_s A_s],'k--');
set (hp(1),'LineWidth',1.5)
axis (range);
f_labels ('Lowpass filter using Hamming window','\it{f/f_s}','{\itA(f)} (dB)')
f_wait

% Blackman window

b = f_firideal (f_type,F,m,fs,3);
[H,f] = f_freqz (b,a,N,fs);
A = 20*log10(abs(H));
[A_s,f0] = f_getAs(b,a,fs,eps(4))
figure
hp = plot (f,A,[0 0.5],-[A_s A_s],'k--');
set (hp(1),'LineWidth',1.5)
axis (range);
f_labels ('Lowpass filter using Blackman window','\it{f/f_s}','{\itA(f)} (dB)')
f_wait
 