%PAM demostration, made by Chao Gao, 01.Dec.2010
%Input f: 1kHz sine wave
%sampling rate (1/Ts): 8kHz
%pulse duty cycle: 10% of the Ts

t=linspace(0,0.002,20000);   % generate the time line, 2ms
f=1000;     % frequency 1kHz
x=sin(2*pi*f*t+pi/3);   % the first sine wave
bsp = [ 1 zeros(1,9) ]; % duty cycle of PAM pulses
spc = kron(bsp, ones(1,125));   % these two lines generate sampling pulse signal
sp = kron( ones(1,16), spc);
pam = x.*sp;    % apply a multiplier
subplot(3,1,1)  % plot the first PAM
plot(t,x,'b', t,sp/10,'m', t,pam+1,'g');
legend('input','sampling pulses','PAM')

x1=sin(2*pi*(f+1000)*t);    % generate another signal, 2kHz
bsp1 = [ (1:10)==4 ];       % the sampling pulse in binary
spc1 = kron(bsp1, ones(1,125));
sp1 = kron(ones(1,16),spc1);
pam1 = x1.*sp1;
subplot(3,1,2)
plot(t,x1,'b',t,sp1/10,'m',t,pam1+1);

subplot(3,1,3)      % output a timely-multiplexed PAM of 2 channels
plot(t,pam+pam1);