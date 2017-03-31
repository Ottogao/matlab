function exam8_5

% Example 8.5: Butterworth filter transfer function 

clear
clc
fprintf('Example 8.5: Butterworth filter transfer function\n\n')

% Compute numerator and denominator

n = 3;
F_c = 10;
a = [1 2 2 1];
omega_c = 2*pi*F_c;
b = 1;
for i = 1 : n+1
   a(i) = a(i)/omega_c^(n+1-i);
end
b = b/a(1)
a = a/a(1)
 
% Plot magnitude response

m = 250;
f = linspace (0,3*F_c,m);
A_a = sqrt(1./(1 + (f/F_c).^(2*n)));
figure
plot(f,A_a)
set (gca,'FontSize',11)
f_labels('Magnitude Response','f (Hz)','A_a(f)')
f_wait
 