%PSK
clf
clear all
N = 20;
t = linspace(0,N,10000);
bk = 2*(rand(1,N)>0.5)-1;

bkt = kron(bk, ones(1,10000/N));

ct = cos(2*pi*5*t);
ask = bkt.*ct;
figure(1);
plot(t,ask, 'b', t, bkt, 'r:');
axis([0,N,-1.5,1.5])

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