function fig1_34

% FIGURE 1.34: Input-output characteristic of an ADC

% Initialize

clc
clear
fprintf ('Figure 1.34: Input-output characteristics of an ADC\n\n')
V_R = 10;
b = V_R/2;
n = 4;
q = V_R/2^n;

% Compute staircase 

figure
p = 10001;
x_a = linspace(-b,b,p);
m = 2^(n-1);
x = -m + floor((x_a + q/2 + b)/q);
x = min(x,m-1);

% Plot it

plot(x_a,x,'LineWidth',1.5)
f_labels ('ADC input-output characteristic','\it{x_a}','\it{x}')
hold on
plot([-b,b],[0,0],'k')
plot([0,0],[-m,m],'k')
f_wait
