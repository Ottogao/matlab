function exam2_15

% EXAMPLE 2.15: Zero-state response

clc
clear
fprintf ('Example 2_15: Zero-state response\n')

% Find poles and zeros

a = [1 -1.2 .32];
b = [0 10 6];
pole = roots(a)
zero = roots(b)

% Compute zero-state response

n = 50;
k = [0 : n-1]';
u = ones(n,1);
y = filter(b,a,u);
figure
h = stem (k,y,'filled','.');
set (h,'LineWidth',1.5)
f_labels ('Zero-state response','\it{k}','\it{y(k)}')
axis([k(1),k(n),0,200])
f_wait
