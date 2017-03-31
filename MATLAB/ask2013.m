% generate OOK signal by multiplying a NRZ unipolar signal with a carrier
N = 10;     % number of bits to be generated
fc = 3;
bk = [ 1 0 0 1 1 0 0 1 0 1 ]; % = rand(1,N)>0.5;
res = 100;  % time resolution
bt = [];    % make signal in time
for k=1:length(bk)
    if(bk(k)==1) bt = [bt ones(1,res)];
    else bt = [bt zeros(1,res)];
    end
end
t = 0:1/res:(N-1/res);
figure(1)
subplot(3,1,1)
plot(t, bt); axis([0 N -0.5 1.5]);
carrier = sin(2*pi*fc*t);
subplot(3,1,2);
plot(t, carrier); axis([0 N -1.5 1.5]);
ook = bt.*carrier;
subplot(3,1,3);
plot(t,ook); axis([0 N -1.5 1.5]);
% raise the levels in NRZ unipolar signal
btr = bt + 0.5;
figure(2)
subplot(2,1,1); plot(t, btr); axis([0 N 0 2]);
ask = btr.*carrier;
subplot(2,1,2); plot(t, ask);