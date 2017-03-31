function exam5_7

% EXAMPLE 5.7:  FIR cascade form realization 

clear
clc
fprintf('Example 5.7: FIR cascade form realization\n\n')
z = [.4+j*.5, .4-j*.5, -.9, .6, -.3]'
b = 3*poly(z)
m = length(z);
a = [1,zeros(1,m)]

% Compute cascade form realization

[B,A,b_0] = f_cascade (b,a)
zeros_1 = roots(B(1,:))
zeros_2 = roots(B(2,:))
zeros_3 = roots(B(3,:))

% Compare direct and cascade form outputs

p = 50;
f_randinit(1000);
x = f_randu (1,p,-1,1);
y1 = f_filtcas (B,A,b_0,x);
y2 = filter (b,a,x);
figure
k = 0 : p-1;
plot (k,y1,k,y2)
f_labels ('FIR cascade and direct form responses','k','y(k)')
f_wait
