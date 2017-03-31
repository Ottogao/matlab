function exam7_9

% Example 7.9: An oversampling DAC 

clear
clc
fprintf('Example 7.9: An oversampling DAC\n\n')
n = 1;
eps = 0.05;
fs = 1;
T = 1/fs;
p = 2000;

% Compute interpolation factor

L = ((1 - eps^2)/eps^2)^(1/(2*n))
L = ceil(L);

% Compute compensated magnitude response

f = linspace (0,fs/2,p);
A = zeros(3,p);
F_a = fs/(2*L);
for i = 1 : p
   if (f(i) <= F_a)
      if i == 1
            A(1,i) = L/T;
      else
            A(1,i) = L/(T*(sin(pi*f(i)*T)/(pi*f(i)*T)));
      end
         A(2,i) = sqrt(1 + (f(i)/F_a)^(2*n));
   end
   A(3,i) = A(1,i)*A(2,i);   
end

% Plot it

figure
plot (f(1:p/10),A(3,1:p/10),'LineWidth',1.5)
f_labels ('Compensated anti-imaging magnitude response','\it{f/f_s}','\it{TA_L(f)}')
f_wait
