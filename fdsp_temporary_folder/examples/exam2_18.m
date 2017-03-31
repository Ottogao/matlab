function exam2_18

% EXAMPLE 2.18: Transfer function of comb filter

clc
clear
fprintf ('Example 2.18: Transfer function of comb filter\n')

% Compute fitler coefficients and poles

r = 0.9;
n = 6;
b = 1;
a = [1 zeros(1,n-1) -r^n];
poles = roots(a)

% Compute and plot |H(z)|

hmax = 2;
N = 81;
circle = 1;
figure
f_pzsurf (b,a,hmax,N,circle);
f_wait

