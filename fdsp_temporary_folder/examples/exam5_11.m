function exam5_11

% EXAMPLE 5.11: Input quantization noise 

clear
clc
fprintf('Example 5.11: Input quantization noise\n\n')
N = 8;
x_m = -10;
x_M = 10;

% Compute quantization noise power at input

q = (x_M - x_m)/2^N
P_x = q^2/12

% Compute quantization noise power at output

a = 0.9
b_0 = 10;
m = 30;
Gamma = b_0^2*(1/(1 - a^2) - a^(2*m)/(1 - a^2))  
P_y = Gamma*P_x
f_wait
