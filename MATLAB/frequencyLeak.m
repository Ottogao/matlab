t=0:0.001:(2.048-0.001);
% s=sin(500*pi*t); 
s = sin(1500*t);
x=fft(s);
figure(1)
plot(t,s);
figure(2)
semilogy(t(1:length(t)/2), abs(x(1:length(x)/2)));