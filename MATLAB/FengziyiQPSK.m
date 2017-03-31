close all;
N = 10000;      % number of bits in the simulation
res = 40;       % timeline resolution
r = 2;          % QPSK bits/symbol rate
T = 10;         % simulation time, 10sec
R = N/T;        % bit rate
Rsym = R/2;     % symbol rate
fc = 1000;      % carrier frequency
fs = Rsym*res;  % sampling rate (how many pieces of data per second)
cutoff = fc/fs/2/2; % LPF filter cutoff frequency, to filter out 2*fc component
B=fir1(res+1,cutoff);   % filter coeffieicent design
range = 1:8*res;    % signal display range
t = 0:1/(Rsym*res):(T-1/(res*Rsym)); % make a timeline
t1 = ones(1,res);   % for kron() function to extend data as signal
A0 = 1;
SNR = 10;

ctI = A0*cos(2*pi*fc*t);
ctQ = A0*cos(2*pi*fc*t + pi/2);

patterns = [1 1 ; 1 -1; -1 1; -1 -1];  % fixed patterns (to see constellation map)
% first show constellation with fixed patterns
for k=1:4
    bk = kron(ones(1,N/r),patterns(k,:));   % extend pattern to be N bits
    bkI = bk(1:2:N); % odd-numbered bits go in-phase;
    bkQ = bk(2:2:N); % even-numbered bits go q-phase;
    BKI = kron(bkI, t1);    % extend data to signal
    BKQ = kron(bkQ, t1);    
    
    % 3. multiply bkI with ctI, and bkQ with ctQ
    branch1 = ctI.*BKI;     % modulate In-phase, and Q-phase
    branch2 = ctQ.*BKQ;

    % 4. add the multiplication results together, it is QPSK
    QPSK = branch1 + branch2;   % add the branches together

    %the received part
    rsig = awgn(QPSK, SNR);   % add gaussian noise with given SNR
    aip=rsig.*ctI;      % demodulate in-phase and q-phase
    aqp=rsig.*ctQ;

    aIPP=filter(B,1,aip);   % pass through LFP to get ride of 2*fc component
    aQPP=filter(B,1,aqp);

    sampleI2=aIPP((res):res:length(aIPP));  % sample the LPF output signal
    sampleQ2=aQPP((res):res:length(aQPP));

    figure(11)
    scatter(sampleI2,sampleQ2,3,'b');
    title('Receiver Constellation map');
    axis([-1 1 -1 1]);
    grid on
    hold on
    %judge / decision making
    aIPPP=2*(sampleI2>0)-1;
    aQPPP=2*(sampleQ2>0)-1;

    sprintf('pattern is %d%d.', patterns(k,1), patterns(k,2))
    pause(1); % pause
end
hold off
% Random bit pattern
bk = 2*(rand(1,N)>0.5)-1;

bkI = bk(1:2:N); 
bkQ = bk(2:2:N); 
BKI = kron(bkI, t1);
BKQ = kron(bkQ, t1);

figure(1)
subplot(2,1,1)
plot(t(range),BKI(range)+2, 'b--', t(range), BKQ(range)-2, 'm--')
title('Transmitter side, In-phase and Q phase baseband')
legend('In-phase','Q-phase');
xlabel('time');
ylabel('amplitude');
% 3. multiply bkI with ctI, and bkQ with ctQ
branch1 = ctI.*BKI;
branch2 = ctQ.*BKQ;

% 4. add the multiplication results together, it is QPSK
QPSK = branch1 + branch2;
subplot(2,1,2);
plot(t(range), QPSK(range));
title('transmitted QPSK')
xlabel('time');
ylabel('amplitude');

%the received part
rsig = awgn(QPSK, SNR);
figure(2);
subplot(2,1,1);
plot(t(range), rsig(range));
title('Received signal');

aip=rsig.*ctI;  % demodulate by carrier
aqp=rsig.*ctQ;
subplot(2,1,2);
plot(t(range), aip(range)+2, t(range), aqp(range)-2);
title('After multiplication of carrier');
legend('In-phase', 'Q-phase');

aIPP=filter(B,1,aip);   % pass through the LPF
aQPP=filter(B,1,aqp);

sampleI2=aIPP((res):res:length(aIPP));  %take samples
sampleQ2=aQPP((res):res:length(aQPP));

figure(3) % plot the output of LPF and samples
plot(t(range), aIPP(range)+2, t(range), aQPP(range)-2);
title('After LPF');
legend('In-phase','Q-phase');
% plot sampled values of first 8 samples
hold on
stem(((res/2+res/2):res:(8*res+res/2))/(Rsym*res), sampleI2(1:8)+2, 'r');
hold off

figure(4)   % show the constellation map of received signal
scatter(sampleI2,sampleQ2,3,'b');
title('Constellation map of received symbols');

% binary detection
aIPPP=2*(sampleI2>0)-1;
aQPPP=2*(sampleQ2>0)-1;
%to get the bit error rate
errI = sum(bkI~=aIPPP);     % find erroneous bit in in-phase data
errQ = sum(bkQ~=aQPPP);     % in q-phase
ber = (errI+errQ)/N;        % calculate BER
sprintf('Ber is %f.\n', ber);   % display BER on console window.

