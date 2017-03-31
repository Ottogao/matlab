% record a piece of voice and let it pass through a 
% low-pass channel
T = 3;
Fs = 44100; % sampling rate of the computer sound system
y = wavrecord(T*Fs, Fs);
freq = fft(y(1:Fs));    % get the frequency domain of the signal
figure(1)
plot(abs(freq(1:Fs/2)));
axis([0 Fs/2-1 0 max(abs(freq))]);
xlabel('Hz'); ylabel('Magnitude');

disp('press any key to play back the original....');
pause;
sound(y, Fs);   % playback the original
% apply a Low-pass filter to let frequency only less than 441Hz
% pass through
B = fir1(400, 0.2); % finite impulse response filter 1st kind
out = filter(B,1,y);    % signal pass through the filter (channel)

disp('press any key to play back the output....');
pause;

sound(out, Fs);