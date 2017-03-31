function exam2_26

% EXAMPLE 2.26: Frequency response 

   clc
   clear
   fprintf ('Example 2.26: Frequency response\n');
   N = 200;
   fs = 2000;
   
% Compute magnitude and phase responses
    
   b = [0 1 1];
   a = [1 0 .64];
   [H,f] = f_freq(b,a,N,fs);
   A = abs(H);
   phi = angle(H);
       
% Plot them on one plot
   
   figure
   subplot(2,1,1)
   plot (f,A,'LineWidth',1.5)
   f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
   subplot(2,1,2)
   plot (f,phi,'LineWidth',1.5)
   f_labels ('Phase response','{\it f} (Hz)','\it{\phi(f)}')
   f_wait

   

   
 
