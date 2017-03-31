function fig5_14

% FIGURE 5.14: Pole-zero pattern of a type 1 linear-phase FIR filter 

clear
clc
fprintf('Figure 5.14: Pole-zero pattern of a type 1 linear-phase FIR filter\n\n')

% Construct a filter

phi = pi/3;
z1 = cos(phi) + j*sin(phi);
z2 = conj(z1);
zero = [-8/9 -9/8 (4/5)*z1 (4/5)*z2 (5/4)*z1 (5/4)*z2]';
b = poly(zero)    
m = length(b) - 1;
a = [1 zeros(1,m)];

% Plot poles and zeros

figure
f_pzplot (b,a,'Type 1 linear-phase filter');
c = 1.5;
axis([-c c -c c])
f_wait
   