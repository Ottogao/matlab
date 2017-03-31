% generate mancheshter 
clf
N = 8;
t = linspace(0,N,100*N);
bk = rand(1,N)>0.5;
nrzi = xor([0 bk], zeros(1,N+1));
nrzi = nrzi(2:N+1);
bkt = kron(bk, ones(1,100));
clk=interleave(ones(1,N),zeros(1,N));
clkt = kron(clk, ones(1,100/2));
nrzit = kron(nrzi, ones(1,100));

figure(1)

plot(t, bkt+3, 'b',t, clkt+1.5, 'r:', t, xor(clkt,bkt),'m', t,nrzit-1.5,'b')
axis([0 N -2 4.5])
legend('NRZ-L','CLK','Output')
set(gca,'XGrid','on') 

