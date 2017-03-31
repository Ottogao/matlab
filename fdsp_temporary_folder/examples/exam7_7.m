function exam7_7

% Example 7.7: Signal synthesis using subbands 

clear
clc
fprintf('Example 7.7: Signal synthesis using subbands\n\n')
fs = 10;
N = f_prompt ('Enter number of subsignals',1,4,4);
p = f_prompt('Enter number of subsignal samples',16,512,64);
m = f_prompt('Enter the FIR filter order m',2,250,120);
f_type = f_prompt('Enter the FIR filter type',0,6,3);
alpha = f_prompt('Enter cutoff frequency scale factor',0,1,0.5);

% Plot spectra of subsignals

X = f_subsignals(p);
figure
Y = fft(X);
f = linspace (-fs/2,(p-1)*fs/(2*p),p)';
A = abs(fftshift(Y));
plot (f,A,'LineWidth',1.5)
f_labels ('Subsignal magnitude spectra','{\itf} (Hz)','\it{A(f)}')
axis ([-fs/2 fs/2 -1 2])
text (0,1.1,'0','HorizontalAlignment','Center')
text (0.1*fs,0.65,'1')
text (0,-0.1,'2','HorizontalAlignment','Center')
text (0,0.7,'3','HorizontalAlignment','Center')
f_wait

% Change sampling rate

L = N;
q = L*p;
y = zeros(q,N);
for i = 1 : N
    y(:,i) = f_tocol(f_interpol(X(:,i),fs,L,m,f_type,alpha));
end
k = [0 : q-1]';

% Construct composite signal

W_N = exp(-j*2*pi/N);
x_c = zeros(q,1);
for i = 1 : N
   x_c = x_c + W_N.^(-(i-1)*k) .* y(:,i);
end
figure
subplot(2,1,1)
plot(k,real(x_c))
f_labels('Composite signal','\it{k}','Real\{\it{x(k)}\}')
subplot(2,1,2)
plot (k,imag(x_c))
f_labels('','\it{k}','Imag\{{\itx(k)}\}')
f_wait

% Compute and plot composite magnitude spectrum

H_x = fft(x_c,q);
A_x = abs(H_x);
f_x = linspace(0,(q-1)*L*fs/q,q);
figure
plot(f_x,A_x,'LineWidth',1.5)
f_labels ('Composite magnitude spectrum','{\itf} (Hz)','\it{A(f)}')
axis([0 L*fs 0 4])
a = 2.75;
text (fs/6,a,'\it{A_0}','HorizontalAlignment','Center')
text (fs,a,'\it{A_1}','HorizontalAlignment','Center')
text (2*fs,a,'\it{A_2}','HorizontalAlignment','Center')
text (3*fs,a,'\it{A_3}','HorizontalAlignment','Center')
text (L*fs-fs/5,a,'\it{A_0}','HorizontalAlignment','Center')
f_wait
