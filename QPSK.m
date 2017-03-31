% QPSK modulation, apply carrier (a sine wave) to binary signals.
N = 16;
f = 1;
bk = 2*(rand(1,N)>0.5)-1;     % generate binary stream, NRZ bipolar
bki = bk(1:2:N);        % separate the binary into two branches
bkq = bk(2:2:N);        % i.e., serial to parallel conversion

t=linspace(0,N,N*200);  % make the time line
bkit=kron(bki,ones(1,200*2));
bkqt=kron(bkq,ones(1,200*2));
cti = sin(2*pi*f*t);
ctq = sin(2*pi*f*t+pi/2);

bpskit=bkit.*cti;       % apply multiplication for two branches
bpskqt=bkqt.*ctq;

qpsk = bpskit + bpskqt; % sum the branches together, it is qpsk
figure(1)
subplot(4,1,1);
plot(t, kron(bk,ones(1,200)));  % plot binary stream
axis([0 N -1.5 1.5]); grid on;
subplot(4,1,2);
plot(t, bkit, t, cti, 'r:');    % plot upper branch
axis([0 N -1.5 1.5]); 
subplot(4,1,3);
plot(t, bkqt, t, ctq, 'r:');    % plot lower branch
axis([0 N -1.5 1.5]); 
subplot(4,1,4);
plot(t, qpsk);                  % plot qpsk output
axis([0 N -1.5 1.5]); 

figure(2)
plot(t, qpsk);