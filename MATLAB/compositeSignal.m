clf
% f1=2;
% f2=3;
% A1=1.5;
% A2=2;
% t=0:0.01:5;
% s1=A1*sin(2*pi*f1*t);
% s2=A2*sin(2*pi*f2*t);
% figure(1)
% plot(t,s1,'r--',t,s2,'m--')
% hold on
% plot(t,s1+s2,'b');
% legend('s1','s2','s1+s2')
A1=1;
f1=1;
A2=1/3;
f2=3;
A3=1/9;
f3=9;
A4=1/5;
f4=5;
A5=1/7;
f5=7;
t=0:0.001:3;
ct = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t) + A4*sin(2*pi*f4*t) + A5*sin(2*pi*f5*t);
figure(1)
plot(t, ct, 'r');
