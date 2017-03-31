function exam1_9

% EXAMPLE 1.9:  Second-order lowpass Butterworth filter

clc
clear
fprintf ('Example 1.9: Second-order lowpass Butterworth filter\n')
n = 2;
f_c = 5000
C = 1.e-8
R_1 = 1/(2*pi*f_c*C)
a_1 = 1.4142;
R_2 = R_1/a_1
f_wait
 