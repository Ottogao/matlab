%test non-block recording, Chao GAO
r = audiorecorder(22050, 16, 1);
record(r,5);     % speak into microphone...
H = waitbar(0,'Recording...');
for k=1:100
    pause(5/100);
    waitbar(k/100);
end
stop(r);
close(H);
p = play(r);   % listen to complete recording
y = getaudiodata(r);