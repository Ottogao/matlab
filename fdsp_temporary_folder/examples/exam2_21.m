function exam2_21

% EXAMPLE 2.21: Convolution

clc
clear
fprintf ('Example 2.21: Convolution\n')

% Find poles and zeros

a = [1 -1.6 .64];
b = 3;
pole = roots(a)

% Compute convolution

r = 60;
[h,k] = f_impulse (b,a,r);
x = 10*sin(pi*k/10);
y = f_conv(h,x,0);
figure
hp = stem (k,y(1:r),'filled','.')
set (hp,'LineWidth',1.5)
f_labels ('Zero-state response','\it{k}','\it{y(k)}')
axis ([k(1),k(r),-300,400])
f_wait
