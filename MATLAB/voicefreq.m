FS = 8000;      % sound card sampling rate
T = 5;          % recording duration
s = wavrecord(T*FS, FS);    % take a record
t=0:1/FS:(T-1/FS);  % display timeline
figure(1);
plot(t, s);     % plot recorded sound by time
freq = zeros(FS,1);
for k=1:T
    s1sec = s((1+k*FS-FS):(k*FS));  % take one second of sound
    freq = freq + fft(s1sec);   % perform Fourier transform and accumulate result
end
figure(2)
plot(0:(FS/2-1), abs(freq(1:FS/2)));
