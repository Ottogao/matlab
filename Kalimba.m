[s fs]= audioread('Kalimba.wav');
range = 1:2000;
p = audioplayer(s, fs);
% sound(s, fs);
playblocking(p);
% re-sample the sound by 2*8 levels
s8 = round(s*8)/8;
disp('press any key to listen a 16-level version');
pause;
sound(s8, fs);
figure(1)
plot(range, s(range), range, s8(range));