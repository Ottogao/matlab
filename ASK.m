%ASK demostration, generate data and plot the spectrum
clf
clear all
N = 20;
ts = 100;
t = 0:1/ts:(N-1/ts);    % make a timeline
bk = rand(1,N)>0.5;     % NRZ signal
bk = bk + 0.5;          % apply an adder
bkt = kron(bk, ones(1,ts));
ct = cos(2*pi*2*t);
ask = bkt.*ct;
figure(1);
plot(t,ask, 'b', t, bkt, 'r:');
axis([0,N,-1.5,1.5])

s1t = ask.*ask;     % apply the square law detector
figure(2)
plot(t, s1t);

b= fir1(101,0.02);
s2t = filter(b,1,s1t);
figure(3)
plot(t,s2t);

spect = zeros(1,10000);
% check the average over a long time of simulation
for k=1:1000
    bbk = rand(1,N)>0.5;
    bbkt = kron(bk,ones(1,10000/N));
    askt = bbkt.*ct;
    spect = spect + abs(fft(askt));
end
figure(2)   % plot the spectrum of ASK, remember the frequency resolution is 
            %   \delta f = 1/T = 1/20 = 0.05 Hz
plot(1:length(spect)/2,abs(spect(1:length(spect)/2)))
figure(3)
plot(1:length(spect)/2, 20*log10(abs(spect(1:length(spect)/2))));