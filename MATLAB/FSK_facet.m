%FSK modulation and demodulation according to FACET digit communication kit
clf
N = 8;      % number of bits in a frame
bits = [ 1 0 1 1 0 0 1 0 ];
RE = 1;   % Repeating times for enough statistics
res = 100; % number of samples in one symbol time
f1 = 1200;  % carrier, low tone
f2 = 2400;  % carrier, high tone
Rsym = 1200;  % symbol rate
t = 0:(1/res/Rsym):(N/Rsym-1/res/Rsym);
c1 = sin(2*pi*f1*t); c2 = sin(2*pi*f2*t);
% design a high-pass filter, cutoff frequency is in the middle of f1,f2
Wp = (f1+(f2-f1)*0.75)/Rsym/res; Ws = (f1+(f2-f1)*0.25)/Rsym/res; 
Rp = 3; % peak-to-peak ripple in the passband, dB
Rs = 60; % stop-band attenuation, dB
[n Wp] = cheb1ord(Wp,Ws,Rp,Rs);
[BPFb BPFa] = cheby1(n, Rp, Wp, 'high');
figure(2)
BPF = fir1(res, [3*f1/Rsym/res 3*f2/Rsym/res], 'bandpass');
freqz(BPFb,1,Rsym,Rsym*res);
LPF = fir1(res/2, 0.5*f1/Rsym/res);
for k = 1:RE
    bits = rand(1,N)>0.5;
    nrz = kron(bits, ones(1,res));
    % apply multiplexer function to generate FSK
    fsk = nrz.*c2 + ~nrz.*c1;
    figure(1)
    subplot(5,1,1);
    plot(t, nrz, t, fsk); axis([0 N/Rsym -1.5 1.5]);
    % apply the BPF filter
    bpf = filter(BPF, 1, fsk);%bpf = filter(BPFb, BPFa, fsk);
    subplot(5,1,2); plot(t, bpf); axis([0 N/Rsym -1.5 1.5]);
    % apply the Full-wave rectifier
    fwr = abs(bpf);
    subplot(5,1,3); plot(t, fwr);  axis([0 N/Rsym -1.5 1.5]);
    % apply the lowpass filter
    lpf = filter(LPF, 1, fwr);
    subplot(5,1,4); plot(t, lpf); axis([0 N/Rsym -1.5 1.5]);
    % apply the voltage comparator
    vcomp = lpf>0.375;
    subplot(5,1,5); plot(t, vcomp); axis([0 N/Rsym -1.5 1.5]);
end
