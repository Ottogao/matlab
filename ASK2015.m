%ASK modulation/demodulation demo
fc = 4;    % carrier frequency
N = 10;     % number of bits
res = 100;  % time resolution of signal
t = 0:1/res:(N-1/res);  % make a time line
an = 0.8;       % noise magnitude (randn generates standard Gaussian with \sigma=1)
rn = 1;         % ASK coefficients (NRZ level is raised by this)
threshold = ((1+rn)^2+1)/4 + an^2;
bk = rand(1,N)>0.5; % make N random bits
bt = kron(bk,ones(1,res));
carrier = sin(2*pi*fc*t);
OOK = bt.*carrier;
ASK = (bt+rn).*carrier;
figure(1); 
subplot(3,1,1); plot(t,bt); axis([0 N -.5 1.5]);
subplot(3,1,2); plot(t,OOK); axis([0 N -1.5 1.5]);
subplot(3,1,3); plot(t,ASK); axis([0 N -2.5 2.5]);
rask = ASK + an*randn(1, length(t)); % add noise to the signal
figure(2); subplot(3,1,1); plot(t, rask);
% work on the demodulator side
sqrask = rask.*rask;
B = fir1(res, 4/res);
filterout = filter(B,1,sqrask);
subplot(3,1,2); plot(t,filterout);
samples = filterout(res:res:end);   % take samples
rbk = samples>(threshold-0.1);
error = sum(bk~=rbk);       % count all the error bits 
error   % display result