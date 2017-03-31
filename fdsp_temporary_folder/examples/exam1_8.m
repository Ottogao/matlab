function exam1_8

% EXAMPLE 1.8:  First-order lowpass Butterworth filter

clc
clear
fprintf ('Example 1.8: First-order lowpass Butterworth filter\n')
n = 1;
f_c = 1000
C = 1.e-8
R = 1/(2*pi*f_c*C)
f_wait
 