function exam9_9

% Example 9.9: Correlation LMS method 

clear
clc
fprintf('Example 9.9: Correlation LMS method\n\n')
m = f_prompt ('Enter filter order m',0,100,25);
alpha = f_prompt ('Enter relative step size alpha',0,1,0.5);
beta = f_prompt ('Enter smoothing factor beta',0,1,0.95);
N = f_prompt('Enter number of samples',2,1200,1200);

% Construct input and desired output

rand('seed',1000)
p = 0.8;
K = 1.28;
a_open = [1 0 -p*p]
b_open = [0 0 K]
poles_open = roots(a_open)
a_closed = a_open + b_open
b_closed = b_open
poles_closed = roots(a_closed)
x = f_randu(N,1,-1,1);
d(1:N/2) = filter (b_closed,a_closed,x(1:N/2));
d(N/2+1:N) = filter (b_open,a_open,x(N/2+1:N));

% Compute the optimal weights

[w,e,mu] = f_corrlms (x,d,m,alpha,beta);

% Plot the input, error, and step size

figure
k = [0 : N-1]';
subplot(2,1,1)
stem (k,e.^2,'filled','.')
f_labels ('Correlation LMS method','\it{k}','\it{e^2(k)}')
subplot(2,1,2)
stem (k,mu,'filled','.')
f_labels ('','\it{k}','\it{\mu(k)}')
f_wait
