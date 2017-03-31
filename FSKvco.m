% FSK generation using VCO (Voltage Controlled Oscillator)
% 
clf 
clear all
N=10;       % number of bits in one simulation, bitrate: 1bps
n=100;      % time resolution of one bit duration
t=linspace(0,N,n*N);
fc = 3;     % carrier frequency
delta = 1;  % frequency deviation
bk = 2*(rand(1,N)>0.5)-1;   % NRZ polar signal
bkt = kron(bk, ones(1,n));
figure(1)
hold on
fsk = cos(2*pi*(fc+bkt*delta).*t+pi/3);  % apply VCO
subplot(2,1,1)      % plot the result
plot(t, bkt)
axis([0 N -1.5 1.5]);
subplot(2,1,2)
plot(t, fsk, 'r');
axis([0 N -1.5 1.5]);
