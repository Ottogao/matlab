t=0:0.001:(2-0.001);
phi = pi/4;
x = sin(2*pi*3*t);
y = sin(2*pi*3*t+phi);

vout_dbm = x.*(y>=0) - x.*(y<0);
figure(1)
plot(t, x+1, t, y+2, 'g--', t, vout_dbm, 'm');
legend('LO','Input','DBM out')
