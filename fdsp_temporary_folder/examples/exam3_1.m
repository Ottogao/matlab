function exam3_1

% EXAMPLE 3.1:  Spectrum of causal exponential 

   clc
   clear
   fprintf ('Example 3.1: Spectrum of causal exponential\n');
   N = 200;
   fs = 1;
   T = 1/fs;
   a = 0.8;
   
% Compute spectra

  f = linspace (-fs/2,fs/2,N);
  X = 1 ./ (1 - a*exp(-j*2*pi*f*T));
  A = abs(X);
  phi = angle(X);
   
% Plot them on one plot
   
   figure
   subplot(2,1,1)
   plot (f,A,'LineWidth',1.5)
   f_labels ('Magnitude spectrum','\it{f/f_s}','\it{A(f)}')
   subplot(2,1,2)
   plot (f,phi,'LineWidth',1.5)
   f_labels ('Phase spectrum','\it{f/f_s}','\it{\phi(f)}')
   f_wait

   

   
 
