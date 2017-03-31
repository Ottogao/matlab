function exam2_20

% EXAMPLE 2.20: Impulse response

clc
clear
fprintf ('Example 2.20: Impulse response\n')

% Find poles and zeros

a = [1 -1.6 .64];
b = 3;
pole = roots(a)

% Compute pulse response

r = 50;
[h,k] = f_impulse (b,a,r); 
figure
hp = stem (k,h,'filled','.')
set (hp,'LineWidth',1.5)
f_labels ('Impulse response','\it{k}','\it{h(k)}')
axis ([k(1),k(r),0 8])
f_wait

