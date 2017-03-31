function cdma_demo(N, n1, n2, Nb)
% CDMA modulation/demodulation demonstration
% made by Chao Gao, 20.Feb.2013
%   N: the order of Walsh code, must be an exponent of 2
%   n1, n2: the code selected, value should be in [1 N]
%   Nb: number of bits to simulate
close all
res = 100;  % timeline resolution per chip

order = log2(N);
N = 2^order;
fc = N*2;     % carrier frequency, 2 cycles/chip
% generate Walsh codes
WN = [1];   % prepare for Walsh code 1st order
for k=1:order
    WN = [WN WN; WN -WN];
end

% select the orthogonal codes for users
if(n1<=N && n2<=N)
    c1 = WN(n1,:); c2 = WN(n2,:);
else % otherwise select first 2 codes
    c1 = WN(1,:);  c2 = WN(2,:);
end

% generate user bits
ub1 = 2*(rand(1,Nb)>0.5) - 1;
ub2 = 2*(rand(1,Nb)>0.5) - 1;
% spread the user bits by user code
uc1 = kron(c1, ub1);
uc2 = kron(c2, ub2);

% make the timeline
t=0:1/res:(N*Nb-1/res);
us1 = kron(uc1, ones(1,res));
us2 = kron(uc2, ones(1,res));
figure(1)
subplot(4,1,1);
plot(t, us1); axis([0 N*Nb -2 2]);
subplot(4,1,2);
plot(t, us2); axis([0 N*Nb -2 2]);
axis([0 N*Nb -3 3]);
% combine 2 users' signal together
combined = us1+us2;
carrier = cos(2*pi*fc*t);
tx = combined.*carrier;
subplot(4,1,3);
plot(t, combined); axis([0 N*Nb -3 3]);
subplot(4,1,4);
plot(t, tx);