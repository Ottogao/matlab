%WCDMA spreading and scrambling, scrambling is used in downlink of CDMA to
%distinguish the user signal from other cells (co-channel interference).
N = 8;          % spreading factor
m = log2(N);    % the order of walsh's law
K = 3;          % number of interfering signals (co-channel number)
res = 100;
W = [1];        % generate Walsh table according to Walsh's rule
for n=1:m
    W = [ W W; W -W ];
end
bits = [-1 1 1]; %2*(rand(1,K)>0.5)-1;   % generate bits from each base station, the first is from its own BTS, the rest are from co-channel.
gain = [1 0.5 0.6];     % gain of each, normalized by the first (own BTS)
cind = ceil(rand()*N); % get the index of spreading code, randomly selected
sprdcode = W(cind,:);

% without scrambling, simply multiply the spreading code with bk
signal = zeros(1,N);    % initialize for accumulation
for k=1:K
    signal = signal + sprdcode*bits(k)*gain(k);
end

% no carrier modulation, only showing the baseband signal
signalt = kron(signal, ones(1,res));
figure(1)
plot(signalt); title('mixed signal, no scrambling'); axis([0 length(signalt) -1.5 1.5]);
figure(2)
stem(signal);

%despread the received signal by the spreading code.
rbk = sprdcode*(signal');   % check the reception
% do the scrambling, first generate 3 scrambling codes
s = zeros(K, N);
for k=1:K
   s(k,:) = 2*(rand(1,N)>=0.5) - 1;
end
signals = zeros(1,N);
for k=1:K
    signals = signals + sprdcode*bits(k)*gain(k).*s(k,:);
end
signalst = kron(signals, ones(1,res));
figure(3)
plot(signalst); title('mixed signal, scrambled');
% receiver part, first descrambling, then despreading
rs = signals.*s(1,:);
drs = sprdcode*(rs');   % check the reception