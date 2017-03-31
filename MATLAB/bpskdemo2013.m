fc = 4;
N = 10;
bku = rand(1,N)>0.5;    % random 10-bit uniplor binaries
bkb = 2*bku - 1;        % bipolar binaries
t = 0:0.01:(N-0.01);    % make time line
carrier = sin(2*pi*fc*t);   % carrier, zero-phase sine wave
figure(1)
subplot(5,1,1)
plot(t, carrier); axis([0 N -1.5 1.5]);
bkut = []; bkbt = [];
for k = 1:N
    if(bku(k)==1) bkut = [bkut ones(1,100)];
    else bkut = [bkut zeros(1,100)];
    end
end
subplot(5,1,2)
plot(t, bkut); axis([0 N -0.5 1.5]);
bkbt = kron(bkb, ones(1,100));
subplot(5,1,3);
plot(t, bkbt); axis([0 N -1.5 1.5]);
ask = (bkut+0.5).*carrier;
psk = bkbt.*carrier;
subplot(5,1,4);  plot(t, ask); axis([0 N -1.5 1.5]);
subplot(5,1,5);  plot(t, psk); axis([0 N -1.5 1.5]);
ask = awgn(ask,10);
sqask = ask.*ask;   % apply the square law 
figure(2)
subplot(2,1,1); plot(t, sqask);
B = fir1(50, 0.1);  % designe the LPF coefficients
lfp = filter(B,1,sqask);
subplot(2,1,2); plot(t, lfp);
samples = lfp(50:1/0.01:end);
hold on
stem(50/100:N, samples, 'r');
hold off
rbk = samples>0.625;
error = sum(rbk ~= bku)