function exam7_1

% Example 7.1: Sampling rate decimator 

clear
clc
fprintf('Example 7.1: Sampling rate decimator\n\n')
fs = 20;
T = 1/fs;
M = 2;
r = 41;
m = 20;
win = 1;
ftype = f_prompt('Enter filter type',0,6,2);

% Construct bandlimited input signal

F_1 = 1;
F_2 = 2;
k = 0 : r;
x = sin(2*pi*F_1*k*T) - 0.5*cos(2*pi*F_2*k*T);
figure
subplot (2,1,1)
hp = stem (k,x,'filled','.');
set (hp,'LineWidth',1.0)
f_labels ('Original samples','\it{k}','\it{x(k)}')
axis ([0 r -2 2])

% Change sample rate by 1/M

[y,b] = f_decimate (x,fs,M,m,ftype);
N = length(y);
subplot (2,1,2)
hp = stem ([0:N-1],y,'filled','.');
set (hp,'LineWidth',1.0)
f_labels ('Decimated samples','\it{k}','\it{y(k)}')
axis ([0 N-1 -2 2])
f_wait
