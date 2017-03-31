%FSK
clf
clear all
N = 10;     % number of bits in one simulation
t = linspace(0,N,10000);    % time from 0 to N seconds, 1bps
bk = rand(1,N)>0.5;
bkt = kron(bk, ones(1,10000/N));
ct1 = cos(2*pi*2*t+pi);      % geneate carriers
ct2 = cos(2*pi*4*t+0);
fsk = ct1.*(bkt==0)+ct2.*(bkt==1);
figure(1);
plot(t,fsk, 'b', t, bkt, 'r:');
axis([0,N,-1.5,1.5])

spect = zeros(1,10000);
% check the average over a long time of simulation
for k=1:1000
    bbk = rand(1,N)>0.5;
    bbkt = kron(bk,ones(1,10000/N));
    fskt = ct1.*(bbkt==1)+ct2.*(bbkt==0);
    spect = spect + abs(fft(fskt));
end
figure(2)   % plot the spectrum of ASK, remember the frequency resolution is 
            %   \delta f = 1/T = 1/10 = 0.05 Hz
plot(1:length(spect)/2,abs(spect(1:length(spect)/2))/1000)
semilogy(1:length(spect)/2,abs(spect(1:length(spect)/2))/1000)