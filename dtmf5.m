fs= 8000;
t= linspace(0,2,fs*2);
fl = 770;
fh = 1336;

ltone = cos(2*pi*fl*t);
htone = cos(2*pi*fh*t);
subplot(3,1,1);
plot(t(1:100), ltone(1:100));
subplot(3,1,2);
plot(t(1:100), htone(1:100));

dtmf = ltone+htone;
subplot(3,1,3);
plot(t(1:100), dtmf(1:100));

soundsc(dtmf, fs);