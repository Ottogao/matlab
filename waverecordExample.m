fs = 8000;
s = wavrecord(fs,fs,1);
t = 0:1/fs:(1-1/fs);
figure(1)
subplot(2,1,1)
plot(t, s);
Y = fft(s);
subplot(2,1,2);
plot(0:(fs/2-1), abs(Y(1:fs/2)));
