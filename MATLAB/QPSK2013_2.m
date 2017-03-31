%QPSK modulation based on the block diagram in the handout
clf;
fc=2;       % carrier frequency
R = 1;      % symbol rate
N = 2000;     % number of bits per frame
res = 100;  % time resolution
bk = rand(1,N)>0.5; % make a frame (N bits) of binary randomly
bk2 = bk*2-1;    % make it as bipolar
% let bk2 pass through a SPC (serial parrellel convertor)
bk2I = bk2(1:2:end);
bk2Q = bk2(2:2:end);
bk2It = kron(bk2I, ones(1,res));        % stretch the binary into signal
bk2Qt = kron(bk2Q, ones(1,res));
% generate carrier signal
t = 0:1/res:(N/2-1/res);
carI = cos(2*pi*fc*t);      % in-phase
carQ = cos(2*pi*fc*t+pi/2); % q-phase
figure(1)
subplot(3,1,1);
plot(t, bk2It+1.5, t, bk2Qt-1.5); axis([0 N/2 -3 3]);
qpsk = bk2It.*carI + bk2Qt.*carQ;
figure(2)
subplot(2,1,1); plot(t, qpsk);
% here below is the QPSK demodulation using local oscillator
rqpsk = awgn(qpsk,10);      % add Gaussian Noise
subplot(2,1,2); plot(t, rqpsk);
rcarI = cos(2*pi*fc*t+pi/4);    % receiver uses local oscillator
rcarQ = cos(2*pi*fc*t+3*pi/4);
rIt = rqpsk.*rcarI; rQt = rqpsk.*rcarQ;
figure(1); 
subplot(3,1,2);
plot(t, rIt+1.5, t, rQt-1.5); axis([0 N/2 -3 3]);

B = fir1(50, 0.05);        % designe a LPF
rIt_lp = filter(B,1,rIt);   % apply the filter to In-phase and Q-phase signals
rQt_lp = filter(B,1,rQt);
subplot(3,1,3);
plot(t, rIt_lp+1.5, t, rQt_lp-1.5); axis([0 N/2 -3 3]);
grid on; box on;
% take samples from both In-&Q-phase
rIsamp = rIt_lp(res/2:res:end);
rQsamp = rQt_lp(res/2:res:end);
figure(3); scatter(rIsamp, rQsamp);
rIbk = rIsamp>0; rQbk = rQsamp>0;
rbk = reshape([rIbk; rQbk], 1, N); % multiplexer
error = sum(rbk ~= bk)          % count the errors