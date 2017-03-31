function exam9_3

% Example 9.3: System identification 

clear
clc
fprintf('Example 9.3: System sdentification\n\n')
rand('seed',1000)
pole = [.5+j*.5,.5-j*.5,.9*j,-.9*j,.8,-.2]';
a = poly(pole)
b = [2 -3 -1 4 5 -8]
r = f_prompt ('Enter number of samples',1,2000,1000);
m = f_prompt ('Enter order of adaptive filter',0,100,50);
mu = f_prompt ('Enter step size',0,1,0.01);

% Construct input and desired output

x = f_randu(r,1,-1,1);
d = filter(b,a,x);

% Identify coefficients using basic LMS method

[w,e] = f_lms (x,d,m,mu);

% Plot squared error

figure
t = [1 : min(500,r)];
stem (t,e(t).^2,'.','filled')
f_labels ('Squared error','\it{k}','\it{e^2(k)}')
f_wait

% Compare magnitude responses

fs = 1;
N= 250;
[Hd,f] = f_freqz (b,a,N,fs);
a1 = [1,zeros(1,m)];
[H,f] = f_freqz (w,a1,N,fs);
figure
plot (f,abs(Hd),f,abs(H),'LineWidth',1.5)
f_labels ('Magnitude responses','\it{f/f_s}','\it{A(f)}')
f_wait
