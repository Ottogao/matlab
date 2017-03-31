% demostration of noise and signal effect in Shannon capacity formula
% It is possible to send data in a very noisy channel.
% A stronger noise can be compensated by slowing-down the bit rate, which
% means the channel capacity is reduced.

% made by Chao Gao 18-09-2008

Nb = 100;         % number of bits in demo
bk = 2*(rand(1, Nb)>0.5)-1;     % generate binaries
Na = 8;        % noise amplitude
Tk = 400;       % time domain resolution, can be also regarded as bit duration
t = linspace(0,Nb,Nb*Tk);
bt = kron(bk, ones(1,Tk));      % make time domain signal for binaries
figure(1)
subplot(4,1,1)
noise = Na*randn(1,Nb*Tk);  % make mean zero noise
plot(t, bt,'r');
axis([0 Nb -2 2]);
subplot(4,1,2)
plot(t,noise,'b');
% axis([0 8 -2 2]);
subplot(4,1,3)
st = noise + bt;
plot(t,st)
rb = zeros(1,Nb);
% at receiver, using maximum likelihood detection
for k=1:Nb      % go through all the binaries
    for n=1:Tk      % for each binary
        rt(n+(k-1)*Tk)= sum( st(((k-1)*Tk+1):((k-1)*Tk+n)) );
    end
    rb(k) = rt(k*Tk);
end
subplot(4,1,4)
rb1 = 2*(rb > 0) - 1;
plot(t,kron(rb1,ones(1,Tk)))
axis([0 Nb -2 2]);

diff = (rb1~=bk);
err = sum(diff)