function exam3_7

% EXAMPLE 3.7:  Uniform white noise 

clear
clc
fprintf('Example 3.7: Uniform white noise\n')
rand ('state',1000)

% Generate white noise signal

N = f_prompt ('Enter number of samples',2,4096,512);
a = -5;
b = 5;
x = a + (b-a)*rand(1,N);

% Plot signal

figure
k = 0 : N-1;
plot (k,x)
axis ([0,N,-10,10])
f_labels ('White noise uniformly disbributed over [-5,5]','\it{k}','\it{x(k)}')
f_wait

% Compute power density spectrum and average power

A = abs(fft(x));
S_N = (A.^2)/N;
P_x = (1/N)*sum(abs(x).^2)
P_u = (b^3 - a^3)/(3*(b - a))

% Plot power density spectrum

figure
i = 1 : N/2;
hp = plot (i-1,S_N(i),[0 N/2],[P_u,P_u],'k');
set (hp(2),'LineWidth',1.5)
axis ([0,N/2,0,80])
title = sprintf ('Power density spectrum of uniform white noise: {\\itP_x} = %.3f',P_x);
f_labels (title,'\it{i}','\it{S_N(i)}')
f_wait
