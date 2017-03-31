%keyboard
h = warndlg('Start to record 5 sec of audio');
waitfor(h);
FS = 8000;
y = wavrecord(5*FS,FS,1);
%keyboard
h = warndlg('Start to playback');
waitfor(h);
sound(y,FS);
figure(1);
t=0:(1/FS):(5-1/FS);
plot(t, y);