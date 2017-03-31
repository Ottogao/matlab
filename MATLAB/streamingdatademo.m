%matlab demostration of streaming data by recording 
% 5-sec sound track.

FS = 8000;
t = 0:1/FS:(5-1/FS);
y = wavrecord(5*FS, FS, 1);
plot(t, y);
sound(y,FS);

for k=1:5
    x = y((1+(k-1)*FS):k*FS);
    sound(x,FS);
    h=pause(0.5);
    waitfor(t);
end