function fig1_30

% FIGURE 1.30: Magnitude response of a zero-order hold

clc
clear
fprintf ('Figure 1.30: Magnitude response of a zero-order hold\n\n')
p = 501;
fs = 1;
fmax = 3*fs;
f = linspace(-fmax,fmax,p);
T = 1/fs;

% Compute magnitude spectra

for i = 1 : p
   s = j*2*pi*f(i);
   if (i == (p+1)/2)
      A(i) = T;
   else
      A(i) = abs((1 - exp(-s*T))/s);
   end
end

% Plot them

figure
plot (f,A,'LineWidth',1.5)
axis ([-fmax fmax 0 1.2*T])
f_labels ('Zero-order hold','{\itf/f_s}','|{\itH_0(f)}|')

% Add ideal characteristic 

hold on
plot ([-fmax -fs/2 -fs/2 fs/2 fs/2 fmax],[0 0 T T 0 0],'k')
legend ('DAC','Ideal reconstruction')
f_wait
