% AM modulation and demodulation
fm = 5;
fc = 200;
m = 1.2;
Vc = 1;
t = 0:0.0001:(1-0.0001);
emt = m*Vc*sin(2*pi*fm*t);
figure(1); 
subplot(5,1,1); plot(t, emt); legend('e_m(t)');
eamt = Vc*(1+m*sin(2*pi*fm*t)).*sin(2*pi*fc*t);
subplot(5,1,2); plot(t, eamt); legend('e_{am}(t)');

noise = 0*randn(1,length(t));
recvd = noise + eamt;
subplot(5,1,3); plot(t, recvd); legend('received');

% signal pass through FWR
fwr_out = abs(recvd);
subplot(5,1,4); plot(t,fwr_out); legend('after FWR');
B = fir1(400, 0.01);
lpf_out = filter(B,1,fwr_out);
subplot(5,1,5); plot(t, lpf_out); legend('after LPF');