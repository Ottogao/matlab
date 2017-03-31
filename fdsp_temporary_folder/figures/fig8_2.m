function fig8_2

% Figure 8.2: Frequency response of a tunable plucked-string filter 

clear
clc
fprintf('Figure 8.2: Frequency response of a tunable plucked-string filter\n\n')

% Compute pulse response

N = 8192;
x = [1,zeros(1,N-1)];
fs = f_prompt ('Enter sampling frequency',20,44100,44100);
f0 = f_prompt ('Enter location of first resonance',100,5000,740);
r = 0.999;
[h,L,c] = f_string (x,f0,fs,r);
L,c

% Compute magnitude response

A = abs(fft(h));
f = linspace(0,(N-1)*fs/N,N);
figure
plot (f(1:N/2)/1000,A(1:N/2),'LineWidth',1.0)
f_labels ('Magnitude response of plucked-string filter','{\itf} (kHz)','\it{A(f)}')
f_wait ('Press any key to play a note...')

% Play output as sound

L = 100;
x(1:L) = f_randu(1,L,-1,1);
y = f_string (x,f0,fs,r);
soundsc(y,fs)
