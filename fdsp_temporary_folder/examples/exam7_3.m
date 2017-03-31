function exam7_3

% Example 7.3: Rational sampling rate converter 

clear
clc
fprintf('Example 7.3: Rational sampling rate converter\n\n')
fs = 20;
T = 1/fs;
L = 3;
M = 2;
r = 41;
m = 20;
ftype = f_prompt('Enter filter type',0,6,2);

% Construct bandlimited input signal

F_1 = 1;
F_2 = 2;
k = 0 : r;
x = cos(2*pi*F_1*k*T) + 0.8*sin(2*pi*F_2*k*T);
figure
subplot (2,1,1)
hp = stem (k,x,'filled','.');
set (hp,'LineWidth',1.0)
f_labels ('Original samples','\it{k}','\it{x(k)}')
axis ([0 r -2 2])

% Change sample rate by L/M

[y,b] = f_rateconv (x,fs,L,M,m,ftype);
N = length(y);
subplot (2,1,2)
hp = stem ([0:N-1],y,'filled','.');
set (hp,'LineWidth',1.0)
f_labels ('Rate-converted samples','\it{k}','\it{y(k)}')
axis ([0 N-1 -2 2])
f_wait
