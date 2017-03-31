function exam9_10

% Example 9.10: Leaky LMS method 

clear
clc
fprintf('Example 9.10: Leaky LMS method\n\n')
m = f_prompt ('Enter filter order m',0,100,20);
mu = f_prompt ('Enter step size mu',0,1,0.002);
nu = f_prompt ('Enter leakage factor nu',0,1,0.9998);
p = f_prompt ('Enter number of samples to predict ahead',0,20,10);
c = f_prompt ('Enter magnitude of white noise',0,1,0.2);

% Construct input and desired output

rand('seed',1000);
N = 100;
k = [0 : N-1]';
v = f_randu(N,1,-c,c);
x = 2*sin(2*pi*k/24) + 3*cos(2*pi*k/8) + v;
d = x;
x_p = zeros(size(x));
x_p(p+1:N) = x(1:N-p);

% Compute the optimal weights

[w,e] = f_leaklms (x_p,d,m,mu,nu);

% Plot the input, output, and error

figure
subplot(3,1,1)
fill ([N-30 N-10 N-10 N-30],[-5 -5 5 5],'c')
hold on
stem (k,x,'filled','.');
f_labels ('Leaky LMS method','\it{k}','\it{x(k)}')
subplot (3,1,2)
y = filter(w,1,x);
fill ([N-30-p N-10-p N-10-p N-30-p],[-5 -5 5 5],'c')
hold on
stem (k,y,'filled','.')
axis ([0,N,-5,5])
f_labels ('','\it{k}','\it{y(k)}')
subplot(3,1,3)
stem (k(1:N-p),e(1:N-p).^2,'filled','.')
f_labels ('','\it{k}','\it{e^2(k)}')
f_wait
