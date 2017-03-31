BER = 10e-6;
L = linspace(10, 1200000, 1000);
FER = 1 - (1-BER).^L;
plot(L, FER);