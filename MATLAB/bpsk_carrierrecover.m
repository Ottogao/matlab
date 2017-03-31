N=1000;
fc=2000;
res = 100;
FS = N*res;
cutoff = 1.5*fc/(res*N/2);
B=fir1(res+1, cutoff, 'high');
rg = 1:8*res;
bk = 2*(rand(1,N)>0.5)-1;
bkt = kron(bk, ones(1,res));
t=0:(1/res/N):(1-1/res/N);
c = cos(2*pi*fc*t);
bpsk = c.*bkt;
bpsk = awgn(bpsk,40);
figure(1);
plot(t(rg), bpsk(rg));

sqbpsk = bpsk.*bpsk;
figure(2);
plot(t(rg),sqbpsk(rg));
hpout = filter(B,1,sqbpsk);
figure(3);
plot(t(rg),hpout(rg));
hold on
[x loc] = findpeaks(hpout);
hold off
ls = loc(10);

rcarrier = hpout(ls:(ls+N*res/2-1));
rcarrier2 = kron(rcarrier, ones(1,2));
figure(4)
plot(t(rg),c(rg), t(rg),rcarrier2(rg));

demod1 = bpsk.*rcarrier2;
figure(5)
plot(t(rg), demod1(rg));