%PSK modulator demo, made by Chao Gao, 08.12.2010

N=10;
bits = rand(1,N)>0.5;
t=0:0.0001:(1-0.0001);
bits_in_time = kron(bits,ones(1,10000/N));
subplot(4,1,1);
plot(t,bits_in_time);
axis([0 1-0.0001 -1 2])
bipol = bits_in_time*2-1;
fc = 20;
carrier = sin(2*pi*fc*t);
subplot(4,1,2)
plot(t,carrier);

psk = carrier.*bipol;
subplot(4,1,3);
plot(t,psk);

noise = 0.5*rand(1,length(t));
received = psk+noise;
subplot(4,1,4)
plot(t,received);