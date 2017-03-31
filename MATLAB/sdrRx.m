%receiver

FS=44100;
T=5;
fc=3000;
fm = 100;
mf = 2;
res=1/FS;
t=0:res:(T-res);
signal = wavrecord(T*FS, FS, 1);
k=waitforbuttonpress;
figure(2)
plot(t, signal)
sound(signal, FS);
k=waitforbuttonpress;
base = fmdemod(signal, fc, FS, fm*mf);
B = fir1(401, 2*fm/FS);
base = filter(B,1,base);
figure(4)
plot(t(1:0.1*FS), base(1:0.1*FS));