%modulation and demodulation of ASK, made by Chao Gao, 22.02.2011
clear all
clf
N=16; bitrate = 2; fc = 8; A = 1;   % parameters
n = 100;                            % time resolution in one bit duration
t=linspace(0,N/bitrate,N*n);        % produce timeline
bk = rand(1,N)>0.5;                 % generate random bit stream
bk(1) = 1;                      % making sure that the first bit has a transition
bkt = kron(bk, ones(1,n));      % producee baseband signal
ct = A*sin(2*pi*fc*t);          % carrier frequency
askt = ct.*bkt;                 % generate ASK
%       additive noise, optional code below...
%An = A/10;
%askt = askt + An*randn(1,n*N);
%       optional code stops here
figure(1)
subplot(3,1,1)
plot(t, askt, 'r', t, bkt,'g');
legend('ASK','baseband')
%demodulation of ASK, using a carrier to multiply the received signal
demodt = askt.*sin(2*pi*fc*t);  % multiply
B = fir1(n+1, fc/2/(2*n));        % a lowpass FIR filter, cutoff is fc/2
baseb = filter(B,1,demodt);     % apply the filter to the 
subplot(3,1,2)
plot(t, demodt, t, baseb, 'r'); 
legend('input*carrier','after LPF');
% then apply a level comparator to the baseb signal
baset = baseb>(A/4);
subplot(3,1,3);
plot(t, baset, 'g')
axis([0,N/bitrate,-0.5,1.5])
% detect values according to the start bit transition time
transp = find(diff(baset));  % find out the transition times
startp = transp(1);
hold on
gca=line( [startp/(2*n) startp/2/n], [-0.5 1.5]);
set(gca, 'Color','m')
text(startp/2/n, 1.4, 'Start bit detected')
rbitk = baset((startp+n/2):n:length(baset));    % sample the incoming baseband signal at right time
stem( ((startp+n/2):n:length(baset))/2/n, rbitk)