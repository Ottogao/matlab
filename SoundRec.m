% Demonsration of sound processing
clf
close all
% Fs = 8000;      % sampling rate
% N = 5;          % duration in seconds
% f=warndlg('Press any key to start the recording...','Record');
% waitfor(f);
% disp(sprintf('Recording...%d secs',N));
% 
% s = wavrecord(N*Fs, Fs, 'double');
[s Fs] = wavread('Kalimba.wav');
freq = fft(s);
figure(1)
theta = linspace(0,Fs/2,length(s)/2);     %Fs*N/2);
semilogx(theta, abs( freq( 1:(length(s)/2) ) ));
xlabel('Frequency(Hz)')

d=warndlg('Now playing the original voice (16-bit)');
waitfor(d);
sound(s, Fs);
s8 = round(s*128)/128;
d=warndlg('Now playing 8-bit resolution voice');
waitfor(d);
sound(s8, Fs);
s6 = round(s*32)/32;
d=warndlg('Now playing 6-bit resolution voice');
waitfor(d);
sound(s6, Fs);
s4 = round(s*8)/8;
d=warndlg('Now playing 4-bit resolution voice');
waitfor(d);
sound(s4, Fs);
t=linspace(0,0.005,Fs*0.005);
sec=1:(Fs*0.005);
figure(2)
plot(t,s(sec)+0.1,'b', t,s8(sec)+0.2,'m', t,s6(sec)+0.3,'r', t,s4(sec)+0.4,'g');
legend('16b','8b','6b','4b')