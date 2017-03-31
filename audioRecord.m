% myVoice = audiorecorder(8000,16,1);
% disp('start...');
% recordblocking(myVoice, 5);
% disp('end!');
% vdata = getaudiodata(myVoice);
clf
vdata = wavrecord(8000,8000,1);
figure(1)
subplot(2,1,1)
plot(vdata);
sound(vdata,8000);
freq = fft(vdata);
subplot(2,1,2)
plot(abs(freq(1:4000)))

% t=linspace(0,1,8000); % t=0:7999;
% f=1000;
% s1 = 0.2*sin(2*pi*f*t);
% sound(s1,8000);
% s2 = 0.2*sin(2*pi*440*t) + 0.1*sin(2*pi*660*t);
% sound(s2,8000);
% figure(2)
% plot(s1(1:100))
% 
% s2 = sin(2*pi*3*t) + 1/3*sin(2*pi*9*t) + 1/9*sin(2*pi*27*t);
% figure(3)
% plot(t,s2)