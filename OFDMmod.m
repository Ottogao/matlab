% OFDM modulation/demodulation, written by Chao Gao, 10.Mar.2011
% each subcarrier is modulated by corresponding bianry branch using BPSK
% pulse shaping filter is not applied in this demonstration
clear all
clf
N = 40;   % number of subcarriers
Tsym = 1; % symbol rate is normalized
nb = 4*N;  % number of bits generated in this simulation, must be a multiple of N
f0 = 4;     % starting subcarrier frequency
fsub = linspace(f0,(f0+(N-1)/Tsym),N);  % make all the subcarrier freqs.
fs = 400;   % number of data in one symbol time
spect = zeros(1,nb/N*fs);           % accumulate spectrum of each run
for RE=1:200
    bk = 2*(rand(1,nb)>0.5)-1;      % generate random binary sfseam
    dk = zeros(N,nb/N);             % initiate S/P converter output
    dkt = zeros(N,nb/N*fs);         % initiate the timeline of S/P
    st = zeros(1,nb/N*fs);          % initiate the IFFT output
    t=linspace(0,nb/N,fs*nb/N);     % prepare timeline
    for k=1:N         % for each subcarrier
        dk(k,:)=bk(k:N:length(bk)); % S/P conversion, extract binaries for this branch
        dkt(k,:)=kron(dk(k,:),ones(1,fs));  % make binaries in bipolar NRZ signal
        st = st + dkt(k,:).*cos(2*pi*fsub(k)*t);%exp(j*2*pi*fsub(k)*t); % modulate the subcarrier
    end
    figure(1)   % plot the combined signal
    plot(t,(st))
    hold on
    for k=1:N
        plot(t, dkt(k,:)/2+2*k);
    end
    hold off
    title(sprintf('OFDM signal of %d subcarriers and %d symbols in time',N,nb/N));
    xlabel('Time(sec)')
    spect = spect + fft(st);    % check the spectrum
%     pause(0.5);
end
% frequency resolution of FFT is deltaf = fs/Ns, where Ns = nb/N*fs is the
% number of samples put into FFT, so deltaf = N/nb.
% therefore we need to display frequency range from 0Hz to fs/2 Hz, which
% is indexed by fs/2/deltaf = fs*nb/N/2;
figure(2)
semilogy(0:N/nb:(fs/2-N/nb),abs(spect(1:fs*nb/N/2)))
title('Spectrum'); xlabel('Hz')

% following is the demodulation part, we demodulate only the last nb bits.
st = st+randn(1,length(st));    % optional Gaussian noise
rt = zeros(N,nb/N*fs);          % prepare receiver branches
for k=1:N           % go through all the branches
    rt(k,:)=st.*cos(2*pi*fsub(k)*t);    % apply FFT to demodulate the recieved signal
    for n=1:nb/N    % go through nb/N symbols in one branch
        idx = 1+(n-1)*fs;   % find bit interval index
        rd(k,n)=sum(rt(k,idx:(idx+fs-1)))/fs;   % detect the binary
    end
end
figure(3)
plot(t, rt(N,:))
title('1st Branch Demodulated - timeline'); xlabel('Time(sec)');
% P/S conversion
rbk = [];    % make an empty buffer
for k=1:nb/N    % go throught all the symbols in branches
    rbk = [rbk rd(:,k)'];
end
figure(4)
stem(1:nb,bk);  % show the sent/received binary
hold on
stem((1:nb)+0.1, rbk, 'r--')
hold off
title('Sent/received binaries')

