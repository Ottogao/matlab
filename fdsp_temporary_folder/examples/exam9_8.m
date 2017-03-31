function exam9_8

% Example 9.8: Normalized LMS method 

clear
clc
fprintf('Example 9.81: Normalized LMS method\n\n')

% Initialize

N = 100;
M = 5;
alpha = f_prompt ('Enter normalized step size alpha',0,1,0.5);
delta = f_prompt ('Enter step size bound delta',0,1,alpha/10);
m = f_prompt ('Enter filter order m',0,100,M);

% Construct input and desired output

k = [0 : N-1]';
x = cos(pi*k/N) .* sin(pi*k/M);
a = [1 1 .9]
b = [1 0 -1]
d = filter (b,a,x);

% Compute the optimal weights

[w,e,mu] = f_normlms (x,d,m,alpha,delta);

% Plot the input, step size, and squared error

figure
N = length(e);
k = [0 : N-1];
subplot(3,1,1)
stem (k,x,'filled','.')
f_labels ('Normalized LMS method','\it{k}','\it{x(k)}')
subplot(3,1,2)
stem (k,mu,'filled','.')
f_labels ('','\it{k}','\it{\mu(k)}')
axis ([0 N 0 12])
subplot(3,1,3)
stem (k,e.^2,'filled','.')
f_labels ('','\it{k}','\it{e^2(k)}')
f_wait
%--------------------------------------------------------------------------------