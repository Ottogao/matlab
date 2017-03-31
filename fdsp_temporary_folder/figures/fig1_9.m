function fig1_9

% FIGURE 1.9:  Input-output characteristic of N-bit quantizer

clc
clear
fprintf ('Figure 1.9: Input-output characteristics of quantizer\n\n')
N = 5;
c = 1;
q = 2*c/2^N
 
% Compute staircase 

figure
p = 10001;
x = linspace(-c,c,p);
Q = f_quant(x,q,0);

% Plot it

plot(x,Q,'LineWidth',1.5)
f_labels ('Quantizer input-output characteristic','{\itx}','{\itQ(x)}')
hold on
plot([-c,c],[0,0],'k')
plot([0,0],[-c,c],'k')
text (-.6,.5,'{\itq} = 0.0625')
f_wait
