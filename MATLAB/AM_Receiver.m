% %AM demodulation
FS=8000;
T=5;
recAM = audiorecorder (FS,16,1);
recordblocking(recAM,T);
AM=getaudiodata(recAM);
t = 0:(1/FS):(T-1/FS);
%AM = wavrecord(T*FS, FS, 1);
%play(recAM);
figure(3);
%plot(t, AM);
plot(AM);


% fwr = AM.*(AM>=0) + (-AM).*(AM<0);
% figure(4);
% plot(fwr);
% 
% B = fir1(101, 0.01);
% demod = filter(B, 1, fwr);
% figure(5)
% plot(demod, 'r');
% 
% axis([0 1-1/FS 0 1])