% FM signal generation 
t=0:0.001:(1-0.001);
fc = 40;
fm = 3;
delta = 12;
x = cos(2*pi*fm*t);
y = cos(2*pi*fc*t + (delta/fm)*cos(2*pi*fm*t));
plot(t,x,t,y,'r')