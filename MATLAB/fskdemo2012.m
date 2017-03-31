%FSK generation using two LOs
clf;
N = 8;
bk = rand(1,N)>0.5;
t = linspace(0,N,N*100);
bkk = kron(bk, ones(1,100));
fc = 2;
delta = 1;
% LO1 = sin(2*pi*(fc+delta)*t);
% LO2 = sin(2*pi*(fc-delta)*t+pi/4);
% FSK = LO1.*bkk + LO2.*(1-bkk);
% 
% figure(1)
% subplot(4,1,1);
% plot(t, bkk);
% subplot(4,1,2);
% plot(t,LO1);
% subplot(4,1,3);
% plot(t,LO2);
% subplot(4,1,4);
% plot(t,FSK);

FSK = sin(2*pi*(fc+(2*bkk-1)*delta).*t+pi/4);
figure(1);
plot(t, bkk+2, 'b',t, FSK);
axis([0 N -1.5 3.5]);
grid on