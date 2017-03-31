function exam1_1

% EXAMPLE 1.1:  Quantization noise

clc
clear
fprintf ('Example 1.1: Quantization noise:\n\n')

% Compute number of bits

x_min = -10;
x_max = 10;
r = 0.001;
c = (x_max - x_min)/sqrt(12*r);
n = log(c)/log(2)
n = ceil(n)
f_wait
