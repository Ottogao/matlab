function exam9_13

% Example 9.13: RLS method 

clear
clc
fprintf('Example 9.13: RLS method\n\n')
rand('seed',1000)
pole = [.5+j*.5,.5-j*.5,.9*j,-.9*j,.8,-.2]';
a = poly(pole);
b = [2 -3 -1 4 5 -8];
N = f_prompt ('Enter number of samples',1,2000,1000);
m = f_prompt ('Enter order of adaptive filter',0,100,50);
gamma = f_prompt ('Enter forgetting factor gamma',eps,1,0.98);

% Construct input and desired output

x = f_randu(N,1,-1,1);
d = filter(b,a,x);

% Identify coefficients using basic LMS method

[w,e] = f_rls (x,d,m,gamma);

% Plot squared error

figure
t = [1 : min(200,N)];
stem (t,e(t).^2,'filled','.')
f_labels ('Squared error','\it{k}','\it{e^2(k)}')
f_wait

% Compare magnitude responses

fs = 1;
q = 250;
[Hd,f] = f_freqz (b,a,q,fs);
a1 = [1,zeros(1,m)];
[H,f] = f_freqz (w,a1,q,fs);
figure
plot (f,abs(Hd),f,abs(H),'LineWidth',1.5)
f_labels ('Magnitude responses','\it{f/f_s}','\it{A(f)}')
f_wait
