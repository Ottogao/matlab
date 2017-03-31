%QPSK receiver
load('rcvdQPSK1k.mat');
FS = 44100;
fc = 1000;
T = length(QPSK)/FS;
t = 0:1/FS:(T-1/FS);
range = 1:(0.6*FS);
%range = (0.4*FS):(0.6*FS);
cutoff = 3.6*fc/(FS/2);
N = 144;
B = fir1(N, cutoff, 'high');
[H,W] = freqz(B,1,N);
figure(1)
plot(t(range), QPSK(range));
figure(2)
subplot(2,1,1);
fqrange = 0:(FS/2)/N:(FS/2-(FS/2)/N);
plot(fqrange, abs(H));
xlabel('Hz');
subplot(2,1,2);
plot(fqrange, angle(H));

qQPSK = power(QPSK,4);
figure(3)
plot(t(range), qQPSK(range));
% test HP filter phase delay by a 8kHz cosine wave
testtone = cos(2*pi*4*fc*t);
testhpout = filter(B,1,testtone);
figure(10)
plot(t(range), testtone(range), t(range), testhpout(range));

deltaF = FS/2/N;
loc_fc = fc*4/deltaF;

q_hp = filter(B,1,qQPSK);

figure(4)
plot(t(range), q_hp(range));