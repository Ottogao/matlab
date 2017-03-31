function exam5_1

% EXAMPLE 5.1:  Linear IIR filter design specifications 

clear
clc
fprintf('Example 5.1: Linear IIR filter design specifications\n')

% Initialize

fs = 1;
T = 1/fs;
N = 200;
F_p = 0.1*fs;
F_s = 0.4*fs;
c = 0.5;

% Compute passband and stopband ripple

theta_p = 2*pi*F_p*T;
delta_p = 1 - 0.5*(1-c)*sqrt((cos(theta_p)+1)^2 + sin(theta_p)^2)/...
          sqrt((cos(theta_p)-c)^2 + sin(theta_p)^2)
theta_s = 2*pi*F_s*T;  
delta_s = 0.5*(1-c)*sqrt((cos(theta_s)+1)^2 + sin(theta_s)^2)/...
          sqrt((cos(theta_s)-c)^2 + sin(theta_s)^2)

% Compute and plot magnitude response 

f = linspace(0,0.5,N);
theta = 2*pi*f*T;
A = 0.5*(1-c)*sqrt((cos(theta)+1).^2 + sin(theta).^2) ./...
    sqrt((cos(theta)-c).^2 + sin(theta).^2);
figure
plot(f,A)
axis ([0 .5 0 1.2])
hold on
plot([F_p,F_p],[0,1],'k--');
fill ([0 F_p F_p 0],[1-delta_p 1-delta_p 1 1],'c')
plot([0 F_s],[delta_s,delta_s],'k--')
fill ([F_s 0.5 0.5 F_s],[0 0 delta_s delta_s],'c')
plot (f,A,'LineWidth',1.5)
text (0.02,1.03,'Passband')
text (.42,.14,'Stopband')
text (.2,.14,'Transition band')
f_labels ('Linear design specifications','\it{f/f_s}','\it{A(f)}')
f_wait
