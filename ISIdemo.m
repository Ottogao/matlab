% demonstration of multipath ISI effect
% BPSK signal is applied and path delays are constants (proprotional to
% distance only). The first path is 1km, 2nd 1.5km, 3rd 2km, with a power
% normalized as 100%, 50%, and 20% respectively. Different bit rate can be
% set to see the multipath ISI effect is very related to it.
clf
N = 16;
res = 100;
R = 1e4;    % bit rate 
fc = R*4;   % carrier frequency is only 4 times greater than the bit rate
Ts = 1/R;   % symbol duration
bk = [1 2*(rand(1,N-1)>0.5)-1];    % generate random binary, 1st bit is always 1
t=0:Ts/res:(N*Ts-Ts/res);
bt = kron(bk, ones(1,res));
carrier = cos(2*pi*fc*t);
bpsk = bt.*carrier;
figure(1)
subplot(4,1,1);
plot(t, bt); axis([0 N*Ts -2 2]); title('baseband signal');
% 3 path length
dist = [1e3 1.5e3 2e3];
delay = dist/3e8;
gain = [0.5 0.3 0.1];
received = bpsk;  % superimpose gaussian noise
rmp = zeros(1,length(received));
bdt = zeros(3,length(received));
for k=1:length(dist) % accumulate mutipath delay to the received signal
    padlen = floor(delay(k)*R*res);
    rmp = rmp + [zeros(1, padlen) gain(k)*received(1:length(received)-padlen)];
    btd(k,:) = [zeros(1, padlen) gain(k)*bt(1:length(received)-padlen)];
end
rmp = awgn(rmp, 20);
subplot(4,1,2);
plot(t, bpsk); axis([0 N*Ts -2 2]); title('tx signal');
subplot(4,1,3);
plot(t, received); axis([0 N*Ts -2 2]); title('signal with awgn');
subplot(4,1,4);
plot(t, rmp); axis([0 N*Ts -2 2]); title('multipath signal');

% receiver, coherent detection with carrier recovery
rsqr = rmp.*rmp;
figure(2)
subplot(4,1,1);
plot(t, rsqr); title('received signal squared');
% in one symbol there are always 4 cycles of carrier, and time res (FS) is
% 100/symbol, so the frequency doubled is 8 cycles per symbol, bandpass
% filter should let [1.5fc 2.5fc] passthrough, which corresponds to
% [1.5*fc/R/(FS/2) 2.5*fc/R/(FS/2)]
B = fir1(101, [ 1.5*fc/R/(res/2) 2.5*fc/R/(res/2) ], 'bandpass');
rsqrf = filter(B,1,rsqr);       % apply the bandpass filter
subplot(4,1,2);
plot(t,rsqrf); title('after a bandpass filter');
% remove the empty caused by delay
rstart = ceil(delay(1)*R)*res;
rsqrf = [rsqrf(rstart+1:end) rsqrf(rstart+1:2*rstart)];  
subplot(4,1,3);
plot(t,rsqrf); title('compensate filter delay');
rcarrier = kron(rsqrf(1:end/2), [1 1]);     % frequency divisor
subplot(4,1,4);
plot(t,rcarrier); title('after freq. divisor');
% now detect
r1 = rmp.*rcarrier;
B = fir1(41, 0.5*fc/R/(res/2));    % lowpass filter
r2 = filter(B,1,r1);
figure(3)
subplot(4,1,1);
plot(t, r2); title('after lowpass filter');
subplot(4,1,2);
plot(t, bt, t, btd(1,:), t, btd(2,:), t, btd(3,:));
legend('original','path 1','path 2','path 3');
title('orginal and delayed signals (baseband)');
subplot(4,1,3);
plot(t, sum(btd,1)); title('multipath combined (baseband)');
