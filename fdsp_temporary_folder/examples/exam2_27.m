function exam2_27

% EXAMPLE 2.27: Steady-state response 

   clc
   clear
   fprintf ('Example 2.27: Steady-state response\n');
   N = 200;
   fs = 2000;
   T = 1/fs;
   f0 = 100;
   
% Compute and plot the magnitude and phase responses
    
   for i = 1 : N
      f(i) = (i-1)*fs/(2*N);
      A(i) = mag(f(i));
      phi(i) = phase(f(i));
   end
   figure
   subplot(2,1,1)
   plot (f,A,'LineWidth',1.5)
   f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
   subplot(2,1,2)
   plot (f,phi,'LineWidth',1.5)
   f_labels ('Phase response','{\itf} (Hz)','\it{\phi(f)}')
   f_wait
  
% Compute and plot steady-state response

   p = 50;
   x = 0.5*ones(1,p);
   y_ss = 0.5*ones(1,p);
   for k = 1 : p
      for i = 1 : 9
         x(k) = x(k) + sinc(pi*i/2)*cos(2*pi*i*f0*(k-1)*T);
         y_ss(k) = y_ss(k) + mag(100*i)*sinc(pi*i/2)*cos(2*pi*i*f0*(k-1)*T + phase(100*i));
      end
   end
   figure
   k = [0 : p-1];
   subplot(2,1,1)
   hp = stem (k,x,'filled','.');
   set (hp,'LineWidth',1.5)
   f_labels ('Periodic pulse train','\it{k}','\it{x(k)}');
   axis ([0 p-1 -.5 1.5])
   subplot(2,1,2)
   hp = stem (k,y_ss,'filled','.');
   set (hp,'LineWidth',1.5)
   f_labels ('Steady-state response','\it{k}','\it{y_{ss}(k)}')
   axis ([0 p-1 -.5 1.5])
   f_wait
   
% Local functions   
      
function A = mag (f)
   
% Return magnitude response at f
   
   T = 1/2000;
   theta = 2*pi*f*T;
   A = 0.2/sqrt((cos(theta)-0.8)^2 + sin(theta)^2);
      
function phi = phase (f)
   
% Return phase response at f
   
   T = 1/2000;
   theta = 2*pi*f*T;
   phi = theta - atan2(sin(theta),cos(theta)-0.8);
      
function y = sinc (x)

% Implement sinc function

   if (abs(x) > 1.e-5)
      y = sin(x)/x;
   else
      y = 1;
   end

   

   
 
