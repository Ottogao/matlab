% demonstration of FFT applied to filter out noise if the signal
% is a set of sinusoidals
% made by Chao Gao, 03.01.2011
clf;
t=linspace(0,1,8000);   % make 1 sec 8000 samples time line
sig = 0.1*sin(2*pi*1000*t); %0.05*sin(2*pi*800*t);    % signal, two sine waves
sound(sig,8000);        % sound the original signal
noise = rand(1,8000)-0.5;   % produce a noise, very strong
mixed = sig + noise;    % mix the noise with signal
figure(1)   
subplot(2,1,1)
plot(t, mixed);         % how does the mixed signal look like ?
sound(mixed,8000);      % sound the noisy signal
freq = fft(mixed)       % apply FFT
subplot(2,1,2);
plot(1:8000/2, abs(freq(1:4000)));  % check the frequency
ffreq = freq.*(abs(freq)>100);  % apply a filter
goodsound = ifft(ffreq);    % use IFFT convert the signal back to time domain
sound(goodsound,8000);  % sound the converted signal
