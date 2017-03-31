% sound test : test your ear sensitivity in frequency and magnitude
disp('This test will test your ear sensitivity in 2-d chart');
disp('The frequency will change in logarithm order,');
disp('Starting from 20Hz, then 40,80,160,320..., to somewhere 16kHz');
disp('For each frequency, the amplitude will start from 1');
disp('Every time decreases 3dB');
freq = [20 40 80 160 320 640 1e3 2e3 4e3 8e3 16e3 18e3];
fs = 44100;
t = 0:1/fs:(3-1/fs);
for k=1:length(freq)
    sprintf('current freq: %d', freq(k))
    sd = sin(2*pi*freq(k)*t);
    for n=1:6
        sound(sd, fs);
        disp('press any key to next level.')
        pause;
        sd = sd/2;
    end
end