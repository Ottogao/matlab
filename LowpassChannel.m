% matlab demostration of lowpass channel to a baseband signal
clf
N=20;       % bit rate is 20bps
bk = rand(1,N)>0.5;
n=100;      % sampling rate is 100*N samples/sec
t=linspace(0,1,n*N);
bt = kron(bk,ones(1,n));    % original signal
figure(1)
plot(t, bt)
axis([0 1 -0.5 1.5])
cutoff = 4/n;                 % cutoff frequency is cutoff*fs/2(Hz)
lpf = fir1(101,cutoff,'low');  % a lowpass filter parameter design
                            
br = filter(lpf,1,bt);
hold on
plot(t, br, 'r')