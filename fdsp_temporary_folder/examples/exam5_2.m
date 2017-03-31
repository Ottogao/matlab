function exam5_2

% EXAMPLE 5.2:  Logarithmic IIR filter design specifications 

clear
clc
fprintf('Example 5.2: Logarithmic IIR filter design specifications\n')

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
Delta_p = 20*log10(1 - delta_p)      
theta_s = 2*pi*F_s*T;  
delta_s = 0.5*(1-c)*sqrt((cos(theta_s)+1)^2 + sin(theta_s)^2)/...
          sqrt((cos(theta_s)-c)^2 + sin(theta_s)^2)
Delta_s = 20*log10(delta_s)      

% Compute and plot magnitude response 

f = linspace(0,0.5,N);
theta = 2*pi*f*T;
A = 0.5*(1-c)*sqrt((cos(theta)+1).^2 + sin(theta).^2) ./...
    sqrt((cos(theta)-c).^2 + sin(theta).^2);
A_r = 20*log10(A);
figure
plot(f,A_r,'LineWidth',1.5)
axis ([0 .5 -40 0])
hold on
plot ([F_p F_p],[-40 Delta_p],'k--')
fill ([0 F_p F_p 0],[Delta_p Delta_p 0 0],'c')
plot([0 F_s],[Delta_s,Delta_s],'k--',[F_s,0.5],[Delta_s,Delta_s],'k');
fill ([F_s 0.5 0.5 F_s],[-40 -40 Delta_s Delta_s],'c')
plot (f,A_r)
text (0.02,-4.0,'Passband')
text (.42,-18,'Stopband')
f_labels ('Logarithmic design specifications','\it{f/f_s}','{\itA(f)} dB')
f_wait
