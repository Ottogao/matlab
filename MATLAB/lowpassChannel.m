clf
FS = 8000;  % sampling frequency of our voice
T = 5;      % recording time
t = 0:1/FS:(T-1/FS);    % make a time vector
s = wavrecord(FS*T, FS);    % record voice 5 seconds
sound(s, FS);   % play the original voice
% design a lowpass filter with cutoff freq fc
fc = 1000;
B = fir1(300, fc/FS/2);
% let the signal pass through the filter
output = filter(B,1,s);
soundsc(output, FS);
figure(1)
plot(t, s, t, output+1);