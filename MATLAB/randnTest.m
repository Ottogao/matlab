N = 100000;
x1 = randn(1,N);
x2 = randn(1,N);
x3 = x1 + x2;
x4 = x1 - x2;
x5 = x1.*x2;

figure(1)
subplot(5,1,1)
plot(x1);
subplot(5,1,2)
plot(x2);
subplot(5,1,3);
plot(x3);
subplot(5,1,4);
plot(x4);
subplot(5,1,5);
plot(x5);

binrange = -5:0.1:5;
xb1 = histc(x1,binrange);
xb2 = histc(x2,binrange);
xb3 = histc(x3,binrange);
xb4 = histc(x4,binrange);
xb5 = histc(x5,binrange);
figure(2)
plot(binrange, xb1, binrange, xb2, binrange, xb3, binrange, xb4, binrange, xb5);
