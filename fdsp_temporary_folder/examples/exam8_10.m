function exam8_10

% Example 8.10: Digital bandpass filter 

clear
clc
fprintf('Example 8.10: Digital bandpass filter\n\n')
f_s = 50;
T = 1/f_s;
F_0 = 5;
F_1 = 15;
  
% Compute analog fitler parameters

Omega_0 = 2*pi*tan(pi*F_0*T)/(pi*T)
Omega_1 = 2*pi*tan(pi*F_1*T)/(pi*T)
 
% Find analog transfer function

bs = [Omega_1-Omega_0 0]
as = [1 Omega_1-Omega_0 Omega_0*Omega_1]
 
% Find digital transfer function

b1 = bs(1)*T/2
a2 = as(3)*(T/2)^2
a(1) = 1 + b1 + a2;
a(2) = -2 + 2*a2;
a(3) = 1 - b1 + a2
b = b1*[1 0 -1]
b = b/a(1)
a = a/a(1)

% Find frequency response

figure
q = 250;
[H,f] = f_freqz (b,a,q,f_s);
A = abs(H);
plot(f,A,'LineWidth',1.5)
axis ([0 f_s/2 0 1.2])
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
hold on
plot ([0 F_1],[1/sqrt(2) 1/sqrt(2)],'k--')
plot ([F_0 F_0],[0 1/sqrt(2)],'k--')
plot ([F_1 F_1],[0 1/sqrt(2)],'k--')
f_wait
