%transmitter

FS=44100;
fc = 3000;
fm = 100;
mf = 2;
res=1/FS;
T=10;
t=0:res:(T-res);

base=sin(2*pi*fm*t);
signal = 0.05*sin(2*pi*fc*t + mf*base);
% signal = 0.05*sin(2*pi*fc*t);
sound(signal, FS);
figure(1)
plot(t, signal)