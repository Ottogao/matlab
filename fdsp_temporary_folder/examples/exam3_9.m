function exam3_9

% EXAMPLE 3.9:  Discrete frequency response 

clear
clc
fprintf('Example 3.9: Discrete frequency response\n')
N = 1024;
m = 8;
fs = 200;
   
% Find pulse response of running average filter
    
a = 1;
b = (1/m)*ones(1,m);
[H,f] = f_freqz (b,a,N,fs);
A = abs(H);
phi = angle(H);
   
% Display results   
   
figure
subplot(2,1,1)
plot (f,A,'LineWidth',1.5)
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
subplot(2,1,2)
plot (f,phi,'LineWidth',1.5)
f_labels ('Phase response','{\itf} (Hz)','\it{\phi(f)}')
f_wait
   
figure
eps = 1.19*10^(-7);
A = 20*log10(max(A,eps));
plot (f,A,'LineWidth',1.5)
axis([f(1) f(N) -150 50])
f_labels ('Magnitude response in decibels','{\itf} (Hz)','{\itA_\epsilon(f)} (dB)')
f_wait

   

   
 
