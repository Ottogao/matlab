% Demonstration of aliasing
% The program generates a sine wave and play it by different
% sampling rates. If the sampling rate Fs < 2*f, we will hear an alias.
clf
Fs1 = 16e3;     % sampling rate 1, no aliasing
Fs2 = 2000;     % sampling rate 2, aliasing
T = 2;          % duration of sound
f = 1700;       % frequency to be played
dr = 100;       % display range
t=0:1/Fs1:(T-1/Fs1);        % make timeline for the first signal
signal = sin(2*pi*f*t);
msg = sprintf('Now play %.3fkHz sound @%dkHz Fs',f/1000, Fs1/1000);
h = msgbox(msg); uiwait(h);
player = audioplayer(signal, Fs1);
playblocking(player); %sound(signal, Fs1);     % play the signal at 16kHz, no aliasing

sloc = 1:Fs1/Fs2:(length(signal));  % re-sample the sound every 8 points
sloc1 = round(sloc);
signal_a = signal(sloc1);
figure(1)
plot(t(1:dr), signal(1:dr));
hold on
plot((sloc1(1:dr*Fs2/Fs1)-1)/Fs1, signal_a(1:dr*Fs2/Fs1), 'r--o');
hold off

msg = sprintf('Now play sampled signal @%dkHz sampling rate',Fs2/1000);
h = msgbox(msg); uiwait(h);
player = audioplayer(signal_a, Fs2);
playblocking(player);   %sound(signal_a, Fs2);

msg = sprintf('Now play %dHz sound(aliasing)', Fs2-f);  % the same sound of alias
h = msgbox(msg); uiwait(h);
signal_b = sin(2*pi*(Fs2-f)*t);
player = audioplayer(signal_b, Fs1);
playblocking(player); %sound(signal_b, Fs1);

ffts16k = fft(signal(1:Fs1));
figure(2)
plot(1:Fs1/2, abs(ffts16k(1:Fs1/2))/(Fs1/2));
title(sprintf('%.3fkHz sound @ %dHz sampling rate', f/1000, Fs1));
xlabel('Hz');

ffts2k = fft(signal_a(1:Fs2));
figure(3)
plot(1:Fs2/2, abs(ffts2k(1:Fs2/2))/(Fs2/2));
title(sprintf('%.3fkHz sound @ %dHz sampling rate', f/1000, Fs2));
xlabel('Hz');

% The rest of the code was copied from somewhere, not in use anymore
% close all
% clear tt_sf
% samples = 10000;
% samp_freq = 20
% nyq = samp_freq/2
% samp_time = samples/samp_freq;
% freq = 12 
% t = [0:samples-1]; 
% tt = t/10000; % each tic is 0.1 msec, therefore 1 sec shows on plot
% size(tt);
% sint = sin(tt);
% radfreq = freq*(2*pi)/1; 
% sint2 = sin(radfreq*tt);
% % radial freq is radfreq, Hz is radfreq/(2*pi) 
% plot(tt, sint2, 'k')
% title('radfreq plot')
% pause(1)
% if nyq - freq < 0 alias = nyq - abs(nyq-freq), end 
% cnt = 1; 
% for ii = 1:samp_time:samples
%   tt_sf(cnt) = ii/samples;
%   cnt=cnt+1; 
% end
% if ii < samples tt_sf(cnt) = samples/10000; end
% sint3 = sin(radfreq*tt_sf);
% hold on
% tt_sf_sze = size(tt_sf,2)
% 
% plot(tt_sf, sint3, 'r')
% 
% 
% figure, plot(tt_sf, sint3, 'r.'), hold on, plot(tt, sint2, 'k')