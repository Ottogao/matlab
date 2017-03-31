N = 16;
An = 1;         % noise level
bk = (rand(1,N)>0.5)*2-1;       % generate random bits
ts = ones(1,100);
t = linspace(0,N,100*N);
bkt = kron(bk,ts);
subplot(4,1,1);
plot(t, bkt);
axis([0 N, -2, 2])
noise = An*randn(1,length(t));
subplot(4,1,2);
plot(t, bkt+noise)%, t, bkt, 'm','linewidth',2);

bk4 = 2*(floor(4*rand(1,N/4))/3)-1;
ts4 = ones(1,400);
bkt4 = kron(bk4,ts4);
subplot(4,1,3)
plot(t, bkt4);
axis([0 N, -2, 2])

subplot(4,1,4);
plot(t, bkt4+noise)%, t, bkt4, 'm', 'linewidth', 2)