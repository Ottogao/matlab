function exam3_15

% EXAMPLE 3.15: Spectrogram 

clear
clc
fprintf('Example 3.15: Spectrogram\n')

% Construct signal and save it

record = 0;
if record == 1
  fs = 8000;
  tau = 4.0;
  [x,N] = f_getsound (tau,fs);
  T = 1/fs;
  save 'vowels' x T
else
   load 'vowels'
   N = length(x);
   fs = 1/T;
end

figure
plot([0:N-1]*T,x)
set (gca,'FontSize',11)
f_labels ('The vowels','{\itkT} (sec)','\it{x(k)}')
dt = [.3 1.15 2.0 2.75 3.5];
vowels = ['A','E','I','O','U'];
for i = 1 : 5
    text(dt(i),.7,vowels(i))
end
f_wait
soundsc (x,fs)

% Compute spectrogram with rectangular window

L = 256;
levels = 12;
rectangle = 0;
[G,f,t] = f_specgram (x,L,fs,rectangle);
figure
contour(f(1:L/2),t,G(:,1:L/2),levels)
f_labels ('Spectrogram of vowels: rectangular window','{\itf} (Hz)','{\itt} (sec)','\it{G(t,f)}')
for i = 1 : 5
    text(4100,dt(i),vowels(i))
end
f_wait

% Compute spectrogram with Hamming window

Hamming = 3;
[G,f,t] = f_specgram (x,L,fs,Hamming);
figure
contour(f(1:L/2),t,G(:,1:L/2),levels)
f_labels ('Spectrogram of vowels: Hamming window','{\itf} (Hz)','{\itt} (sec)',...
          '\it{G(t,f)}')
for i = 1 : 5
    text(4100,dt(i),vowels(i))
end
f_wait
