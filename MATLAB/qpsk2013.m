% QPSK modulation and demodulation
N=1600+8; fc=2;
bk = [-ones(1,4) ones(1,4) 2*(rand(1,N-8)>0.5)-1];
bkI = bk(1:2:N);  % S-P convertor
bkQ = bk(2:2:N);
% generate bipolar NRZL signals in I-Q phases
res  = 100; % time resolution of the signal
bkIt = kron(bkI, ones(1,res));
bkQt = kron(bkQ, ones(1,res));
t = 0:1/res:(N/2-1/res);
carrierI = cos(2*pi*fc*t);
carrierQ = cos(2*pi*fc*t-pi/2);
aI = bkIt.*carrierI;
aQ = bkQt.*carrierQ;
qpsk = aI + aQ;
figure(1);
range = 1:(8*res-1);
subplot(2,1,1); plot(t(range),bkIt(range)+1.5,t(range),bkQt(range)-1.5);
subplot(2,1,2); plot(t(range), qpsk(range));

% now is the receiver part
r = qpsk + 1.5*randn(1, N/2*res);
aIp = r.*carrierI;  % received signal multiply with carrier
aQp = r.*carrierQ;
B = fir1(101, fc/res);
aIpp = filter(B,1,aIp);
aQpp = filter(B,1,aQp);
% find the first transition time
trans = find(aIpp>0.01);
trans = trans(1);
sampleI = aIpp(trans+res/2:res:length(aIpp));
sampleQ = aQpp(trans+res/2:res:length(aQpp));
% plot constellation map of received signal
figure(3);
scatter(sampleI, sampleQ, 3, 'r');
axis([-1.5 1.5 -1.5 1.5]);
aIppp = aIpp>0;
aQppp = aQpp>0;
figure(2); 
range = 1:(8*res-1);
subplot(2,1,1); plot(t(range), aIpp(range), t(range), aQpp(range));
legend('In-phase','Q-phase');
subplot(2,1,2); plot(t, r);