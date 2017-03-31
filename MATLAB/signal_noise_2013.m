t=0:1/8000:5;
% signal = sin(2*pi*1000*t);
% sound(signal, 8000)
% signal1 = signal + rand(1, length(signal));
% sound(signal1, 8000)
% signal2 = signal + 0.2*rand(1, length(signal));
% sound(signal2, 8000)
% sound(signal1, 8000)
% sound(signal, 8000)
% figure(1)
% plot(t,signal, t,signal1, t,signal2)

dialtone = sin(2*pi*350*t) + sin(2*pi*440*t);
sound(dialtone, 8000);