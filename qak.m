% Exam question for 2010, Quadrature ASK: 4 levels ASK
clf
clear all
N = 8;
ts = 1000;
t=linspace(0,N,N*ts);
fc = 1;
sc = cos(2*pi*fc*t);
bk = [1 1 0 1 1 0 0 0]; %rand(1,N)>0.5;
n = 1:2:(N-1);
qk = [3 2.25 0.75 0] - 1.5;%(bk(n)*2 + bk(n+1)) - 1.5;
bkt = kron(bk, ones(1,ts));
qkt = kron(qk, ones(1,2*ts));
signal = sc.*qkt/1.5;
subplot(3,1,1);
plot(t,bkt);
axis([0 N -0.5 1.5])
xlabel('binary(NRZL)');
for k=1:N
    text(k-0.5,1.1,sprintf('%d',bk(k)));
end
subplot(3,1,2);
plot(t,sc);
xlabel('carrier');
subplot(3,1,3);
plot(t, signal, t, ones(1,N*ts)*0.5, 'r:', t, -ones(1,N*ts)*0.5, 'r:');
xlabel('Signal');
