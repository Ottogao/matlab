%BPSK modulator and demodulator
clf
N=10;
fc=2;
res = 100;  % signal resolution in time
bk=rand(1,N)>0.5;
t=0:(1/res):(N-1/res);
bkt = kron(bk, ones(1,res));
figure(1)
subplot(3,1,1)
plot(t, bkt);
axis([0 N-1/res -1.5 1.5]);
bktbp = 2*bkt -1;
subplot(3,1,2)
plot(t, bktbp, 'r-');
axis([0 N-1/res -1.5 1.5]);
carrier = cos(2*pi*fc*t);   % later change phase to see coherent detection
bpsk = bktbp.*carrier;
subplot(3,1,3);
plot(t, bpsk);

r = bpsk + randn(1,N*res);  % mix the received signal with Gaussian Noise
% start the demodulation
rcarrier = cos(2*pi*fc*t-pi/2);
spt = r.*rcarrier;
figure(2);
subplot(3,1,1);
plot(t,spt);
B = fir1(101, fc/res);
sppt = filter(B, 1, spt);
subplot(3,1,2);
plot(t, sppt);
rkt = sppt>0;
subplot(3,1,3);
plot(t, rkt);
axis([0 N-1/res -0.5 1.5]);

