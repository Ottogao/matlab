function exam5_9

% EXAMPLE 5.9:  IIR parallel form realization 

clear
clc
fprintf('Example 5.9: IIR parallel form realization\n\n')
p = [-.3+j*.4 -.3-j*.4 .8 -.7]'
a = poly(p)
b = [2 0 0 2 0]

% Compute parallel form realization

[B,A,R_0] = f_parallel (b,a)

% Compare direct and parallel form outputs

p = 50;
f_randinit(1000);
x = f_randu (1,p,-1,1);
y1 = f_filtpar (B,A,R_0,x);
y2 = filter (b,a,x);
figure
k = 0 : p-1;
plot (k,y1,k,y2)
f_labels ('IIR parallel and direct form responses','k','y(k)')
f_wait
