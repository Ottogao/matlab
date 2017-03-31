clf
x = 0:1/1000:(4*pi-1/1000);
a = 1;
% s1 = 4*a/pi*sin(x);
% s3 = 4*a/(3*pi)*sin(3*x);
% s5 = 4*a/(5*pi)*sin(5*x);
% s7 = 4*a/(7*pi)*sin(7*x);
N =5;
square = zeros(1, length(x));
for k=1:N
    s = 4*a/((2*k-1)*pi)*sin((2*k-1)*x);
    square = square + s;
end
% square = s1 + s3 + s5 + s7;
figure(1);
plot(x, square);
% plot(x, s1, x, s3, x, s5, x, s7, x, square);
% legend('s1','s3','s5','s7','synthezised');
% take the first component of this square wave away
distorted = square - 4*a/pi*sin(x);
hold on
plot(x, distorted, 'r');
hold off