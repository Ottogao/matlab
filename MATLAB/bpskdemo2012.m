%BPSK signal modulation
clf;
N = 17;
fc = 3;
A = 1;
bk = rand(1,N)>0.5;
t = linspace(0,N,N*100);
bkk = kron(bk, ones(1,100));
bipolar = 2*bkk-1;
ct = A*sin(2*pi*fc*t);
psk = bipolar.*ct;

figure(1)
plot(t,bkk+2,'b', t,psk,'r');
axis([0 N -1.5 3.5]);