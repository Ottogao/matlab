function exam6_6

% EXAMPLE 6.6:  Lowpass filter with optimal transition band sample 

clear
clc
fprintf('Example 6.6: Lowpass filter with optimal transition band sample\n\n')
sym = 0;
fs = 1;
F_0 = fs/4;
m = f_prompt ('Enter fitler order',1,100,20);
N = m+1;
i = 0 : m/2;
fi = i*fs/N;
m0 = m/4+1;
a = [1,zeros(1,m)];
eps = 50;

% Find optimal transition band sample

x = [.25,.5,.75];
for i = 1 : 3
   A = [ones(1,m0),x(i),zeros(1,m/2-m0)];
   b = f_firsamp (A,m,fs,sym);
   [y(i),f0] = f_getAs (b,a,fs,eps);
end

% Interolate quadratic polynomial and find maximum

X = [1 x(1) x(1)^2; 1 x(2) x(2)^2; 1 x(3) x(3)^2];
c = X\y'
xmax = -c(2)/(2*c(3))
A = [ones(1,m0),xmax,zeros(1,m/2-m0)];
b = f_firsamp (A,m,fs,sym);
[Amax,f0] = f_getAs (b,a,fs,eps)

% Compute magnitude response

p = 256;
[H,f] = f_freqz (b,a,p,fs);
B = abs(H);
figure
subplot(2,1,1)
hp = plot (f,B,fi,A,'ro');
set (hp(1),'LineWidth',1.5)
axis([0 .5 0 1.5])
f_labels ('Linear magnitude response','\it{f/f_s}','\it{A(f)}')
hold on
plot ([0 F_0 F_0 fs/2],[1 1 0 0],'k')
legend ('Filter','Samples','Ideal')

% Display logarithmic magnitude response

subplot(2,1,2)
C = 20*log10(abs(H));
plot(f,C,'LineWidth',1.5)
f_labels ('Logarithmic magnitude response','\it{f/f_s}','{\itA(f)} (dB)');
hold on
[A_s,f0] = f_getAs (b,a,fs,eps);
plot ([0 fs/2],[-A_s -A_s],'k--')
axis ([0 .5 -100 20])
A_str = sprintf ('\\it{A_s} = %.1f dB',A_s);
text (.1,-70,A_str)
f_wait
