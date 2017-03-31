% demonstration of 2B1Q signal generation
% made by Chao Gao, 26.01.2011
N = 16;
bits = (rand(1,N)>0.5);

First = bits(1:2:N);
Second = bits(2:2:N);
Level = (2*First + Second)*2-3;

t=linspace(0,1,1600);
signal = kron(Level, ones(1,1600/8));
NRZt = kron(bits, ones(1,1600/16))-0.5;
plot(t,signal, t, NRZt,'r--');
axis([0 1 -4 4]);
legend('2B1Q','NRZ polar');