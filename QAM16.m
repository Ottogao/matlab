% 16QAM modulation demo, made by Chao Gao 16.02.2011
% based on the blockdiagram as follows:
% 1.....input bit stream ----> serial/parallel convertor (4bit->2x2bit)
% 2.....the separated bits are fed into a 2-bit D/A convertor
% 3.....the output will multiply Inphase / Quadraturephase carrier
%       respectively
% 4.....The results of multiplications are added together
%
% the constellation diagram of current design is
%                      |
%          *       *  1.5  *       *
%         0011    0111 |  1011    1111
%                      |
%          *       *  0.5  *       *
%         1011    0110 |  1010    1110
%  --------------------+---0.5-----1.5--------
%                      |
%          *       * -0.5  *       *
%         0001    0101 |  1001    1101
%                      |
%          *       * -1.5  *       *
%         0000    0001 |  0010    0011
%                      |
clf
clear all
N = 32;                     % number of bits simulated
r = 4;                      % r=1/4, 1symbol=4bits
f = 2;                      % carrier frequency
bk = rand(1,N)>0.5;         % generate random bit stream
n = 1000;                   % time resolution, values per second
t = linspace(0,N/r,N/r*n);  % timeline, symbol rate 1sps

bkt = kron(bk, ones(1,n/r));    % extend binary in time
indexI = [1:r:N; 2:r:N];    % alternate: 1:2:N
indexQ = [3:r:N; 4:r:N];    % alternate: 2:2:N
bI = bk(indexI);            % separate bits (1,2,5,6,...) to inphase
bQ = bk(indexQ);            % separate bits (3,4,7,8,...) to quadrature phase
% apply D/A converter for In-phase and Q-phase bits respectively
LevI = bI(1:2:N/2)*2 + bI(2:2:N/2); % amplitudes of inphase (every 2bits combined)
LevQ = bQ(1:2:N/2)*2 + bQ(2:2:N/2); % amplitudes of q-phase
LevI = LevI - 1.5;          % shift the amplitudes in [-1.5, 1.5]
LevQ = LevQ - 1.5;
LevIt = kron(LevI, ones(1,n));  % extend binary values to time
LevQt = kron(LevQ, ones(1,n));
cIt = cos(2*pi*f*t);        % inphase carrier
cQt = cos(2*pi*f*t+pi/2);   % quadraturephase carrier
qam16 = LevIt.*cIt + LevQt.*cQt;    % generate QAM16 by adding two branches together
figure(1)
subplot(3,1,1);             % plot binary stream first
plot(t,bkt); axis([0 N/r -0.5 1.5]);
for k=1:N       % print binary values in figure
    text((k-1)*0.25+0.1,1.2,sprintf('%d',bk(k)));
end
grid on
subplot(3,1,2);
plot(t,LevIt,'g--'); axis([0 N/r -2 2]);
for k=1:N/4     % print inphase binaries in figure
    text((k-1)+0.4, 1.6, sprintf('%d%d',bI(2*k-1),bI(2*k)));
end
subplot(3,1,3);
plot(t,LevQt,'m--');axis([0 N/r -2 2]);
for k=1:N/4     % print Q-phase binaries in figure
    text((k-1)+0.4, 1.6, sprintf('%d%d',bQ(2*k-1),bQ(2*k)));
end
figure(2)
plot(t,qam16);

