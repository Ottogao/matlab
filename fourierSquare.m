close all
clear all
t = 0:0.01:5;
f = 1;
s1 = cos(2*pi*f*t);
s2 = -1/3*cos(2*pi*3*f*t);
s3 = 1/5*cos(2*pi*5*f*t);
s4 = -1/7*cos(2*pi*7*f*t);
s5 = 1/9*cos(2*pi*9*f*t);
subplot(3,1,1);
plot(t, s1, 'r', t, s2, 'b', t, s3, 'm');
legend('fundamental','3rd Harmonic','5th Harmonic')
subplot(3,1,2);
plot(t, s1+s2, 'g', t, s1+s2+s3+s4+s5, 'r--');
legend('1+3','1+3+5+7+9');
subplot(3,1,3);
plot(t, s1+s2+s3, 'r-', t, s1+s2+s3+s4, 'b--');
legend('1+3+5','1+3+5+7')