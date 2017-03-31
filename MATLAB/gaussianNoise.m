t=0:0.001:(1-0.001);
bk = rand(1,8)>0.5;
bt = kron(bk, ones(1,length(t)/8));
gn = 2*randn(1,length(t));
%nn = 0.5*rand(1,length(t));
figure(1)
plot(t, gn, t, bt, 'r');
axis([0 1 -5 5])
legend('gn','bt')
rt = gn + bt;
figure(2)
plot(t, rt);
axis([0 1 -5 5])
