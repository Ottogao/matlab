function fig1_27

% FIGURE 1.27: Magnitude reponses of lowpass Butterworth filters

clc
clear
fprintf ('Figure 1.27: Magnitude responses of lowpass Butterworth filters\n\n')
p = 501;
fc = 1;
fmax = 4*fc;
f = linspace(0,fmax,p);
nmax = 4;

% Compute magnitude spectra

for n = 1 : nmax
   for i = 1 : p
      k = 2^n;
      B(n,i) = 1/sqrt(1 + (f(i)/fc)^(2*k));
   end
end

% Plot them

figure
plot (f,B,'LineWidth',1.5)
axis ([0 fmax 0 1.2])
f_labels ('','{\itf} (Hz)','|{\itH_a(f)}|')
title ('Butterworth filters')
text (2,.28,'2')
text (1.7,.15,'4')
text (1.4,.1,'8')
text (1.05,.04,'16')

% Add ideal characteristic 

hold on
plot ([0 fc fc fmax],[1 1 0 0],'k','LineWidth',1.0)
f_wait 
