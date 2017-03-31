function exam5_8

% EXAMPLE 5.8:  FIR lattice form realization 

clear
clc
fprintf('Example 5.8: FIR lattice rorm realization\n\n')
b = [2 6 -4];

% Compute lattice form realization

[K,b_0] = f_lattice (b)

% Compare direct and cascade form outputs

p = 50;
f_randinit(1000);
x = f_randu (1,p,-1,1);
y1 = f_filtlat (K,b_0,x);
a = 1;
y2 = filter (b,a,x);
figure
k = 0 : p-1;
plot (k,y1,k,y2)
f_labels ('FIR lattice and direct form responses','k','y(k)')
f_wait
