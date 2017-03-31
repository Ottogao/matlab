f1 = 350;   % first tone
f2 = 440;   % second tone
T = 5;
fs = 8000;
rs = 1/fs;
t = 0:rs:(T-rs); % make a time
signal = cos(2*pi*f1*t) + cos(2*pi*f2*t);   % make the signal
figure(1)
plot(t(1:fs*0.1), signal(1:fs*0.1));
title('original signal');
pause
noise = 0.01*randn(1,length(t));
rec = signal + noise;
figure(2);
plot(t(1:fs*0.1), rec(1:fs*0.1));
sound(signal, fs);
pause
sound(rec, fs);