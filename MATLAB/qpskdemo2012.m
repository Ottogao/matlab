%QPSK modulation demo
N = 16;
fc = 2;
bk = rand(1,N)>0.5;
bkup = bk(1:2:N);
bkdown = bk(2:2:N);
t = linspace(0,N/2,N/2*100);
ctup = cos(2*pi*fc*t);
ctdown = cos(2*pi*fc*t-pi/2);
bkkup = kron(bkup, ones(1,100));
bkkdown = kron(bkdown, ones(1,100));
outup = (2*bkkup-1).*ctup;  % make bipolar output for both branches
outdown = (2*bkkdown-1).*ctdown;
qpsk = outup + outdown;
noise = 0.2*randn(1,N/2*100);
recived = qpsk + noise;
clf
figure(1);
subplot(5,1,1);
plot(t, bkkup); axis([0 N/2 -0.5 1.5]);
subplot(5,1,2); 
plot(t, bkkdown); axis([0 N/2 -0.5 1.5]);
subplot(5,1,3);
plot(t, outup);
subplot(5,1,4);
plot(t, outdown);
subplot(5,1,5);
plot(t, qpsk);
figure(2)
plot(t,recived);