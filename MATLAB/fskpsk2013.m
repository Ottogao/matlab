% modulation and demodulation of FSK and PSK
N = 8;
FN = 6;
f0 = 2;
f1 = 4;
deltaf = f1 - f0;
rs = 1000;
t = 0:1/rs:(N-1/rs);
bk = rand(1,N)>0.5;
fskc1 = sin(2*pi*f0*t);
fskc2 = sin(2*pi*f1*t);
unipolarbt = kron(bk, ones(1,rs));
fsk = fskc2.*(unipolarbt==1) + fskc1.*(unipolarbt==0);
figure(1)
subplot(FN,1,1); plot(t, unipolarbt); axis([0 N -0.5 1.5]);
subplot(FN,1,2); plot(t, fskc1);
subplot(FN,1,3); plot(t, fskc2);
subplot(FN,1,4); plot(t, fsk);

% to produce PSK, we need to turn an unipolar signal into bipolar
bipolar = 2*unipolarbt - 1;
subplot(FN, 1, 5); plot(t, bipolar); axis([0 N -1.5 1.5]);
pskcarrier = fskc1;
psk = bipolar.*pskcarrier;
subplot(FN, 1, 6); plot(t, psk);