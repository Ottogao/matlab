function exam6_5

% EXAMPLE 6.5:  Lowpass filter with transition band sample 

clear
clc
fprintf('Example 6.5: Lowpass filter with transition band sample\n\n')
sym = 0;
fs = 1;
F_0 = fs/4;
m = f_prompt ('Enter fitler order',1,100,20);
N = m+1;
i = 0 : m/2;
fi = i*fs/N;
m0 = m/4+1;
A = [ones(1,m0),0.5,zeros(1,m/2-m0)];
eps = 40;

% Compute filter coefficients

b = f_firsamp (A,m,fs,sym);
a = [1,zeros(1,m)];

% Compute magnitude response

p = 256;
[H,f] = f_freqz (b,a,p,fs);
B = abs(H);
figure
subplot(2,1,1)
hp = plot (f,B,fi,A,'ro');
set (hp(1),'LineWidth',1.5)
axis ([0 .5 0 1.5])
f_labels ('Linear magnitude response','\it{f/f_s}','\it{A(f)}')
hold on
plot ([0 F_0 F_0 fs/2],[1 1 0 0],'k')
legend ('Filter','Samples','Ideal')

% Display logarithmic magnitude respone

subplot(2,1,2)
C = 20*log10(abs(H));
plot(f,C,'LineWidth',1.5)
f_labels ('Logarithmic magnitude response','\it{f/f_s}','{\itA(f)} (dB)');
hold on
[A_s,f0] = f_getAs (b,a,fs,eps);
plot ([0 fs/2],[-A_s -A_s],'k--')
axis([0 .5 -100 20])
A_str = sprintf ('\\it{A_s} = %.1f dB',A_s);
text (.1,-65,A_str)
f_wait
