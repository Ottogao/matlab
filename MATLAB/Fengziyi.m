fc = 200;
FS = 8000;
t = 0:(1/FS):(1-1/FS);
carrier = sin(2*pi*fc*t);
wavplay(carrier, FS);
fm = 10;
signal = sin(2*pi*fm*t);
m = 0.5;
am = (1+m*signal).*carrier;
figure(1)
plot(t, am);
figure(2)
plot(t, carrier)
for k=1:10
    soundsc(am, FS);
end