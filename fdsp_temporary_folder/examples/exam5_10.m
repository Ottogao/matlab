function exam5_10

% EXAMPLE 5.10: IIR cascade form realization 

clear
clc
fprintf('Example 5.10: IIR cascade form realization\n\n')
p = [-.3+j*.4, -.3-j*.4, .8, -.7]'
a = poly(p)
b = [2 0 0 2 0]

% Compute cascade form realization

[B,A,b_0] = f_cascade (b,a)

% Compare direct and cascade form outputs

p = 50;
f_randinit(1000);
x = f_randu (1,p,-1,1);
y1 = f_filtcas (B,A,b_0,x);
y2 = filter (b,a,x);
figure
k = 0 : p-1;
plot (k,y1,k,y2)
f_labels ('IIR cascade and direct form responses','k','y(k)')
f_wait