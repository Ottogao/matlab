function fig7_29

% Figure 7.29: Magnitude response of zero-order hold 

clc
clear
fprintf ('Figure 7.29: Magnitude response of zero-order hold\n\n')
p = 501;
fs = 1;
fmax = 5*fs;
f = linspace(0,fmax,p);
T = 1/fs;
L = 1;

% Compute magnitude spectra

for i = 1 : p
   if (i == 1)
      A(i) = T/L;
   else
      A(i) = (T/L)*abs(sin(pi*f(i)*T/L))/(pi*f(i)*T/L);
   end
end

% Plot it

figure
plot (f,A,'LineWidth',1.5)
axis ([0 fmax 0 1.2*T])
f_labels ('Zero-order hold','\it{f/(Lf_s)}','\it{(L/T)A_0(f)}')
f_wait
