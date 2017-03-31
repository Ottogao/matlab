% generate sinusoidal sound at different freq.

t=0:(1/16000):3;
f=5000;
s = cos(2*pi*f*t);
sound(s,16000)