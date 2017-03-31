function fig5_37

% FIGURE 5.37: Input-output characteristic of an N-bit quantizer

clc
clear
fprintf ('Figure 5.37: Input-output characteristics of an N-bit quantizer\n\n')
N = 4;
q = 2^(1-N);
c = 1;
 
% Compute staircase 

figure
p = 10001;
x = linspace(-c,c,p);
Q = f_quant(x,q,0);
Q = f_clip(Q,-c,c-q);

% Plot it

plot(x,Q,'LineWidth',1.5)
f_labels ('Quantizer input-output characteristic','\it{x}','\it{Q_N(x)}')
hold on
plot([-c,c],[0,0],'k')
plot([0,0],[-c,c],'k')
qstr = sprintf ('{\\itq} = %.3f',q);
text (-.6,.5,qstr)
f_wait
