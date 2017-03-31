function exam4_14

% Example 4.14: Speech analysis and pitch 

clear
clc
fprintf('Example 4.8.2: Speech Analysis and Pitch\n')

% Load sound data and plot it

load vowel_e
N = length(e);
k = 0 : N-1;
fs = 8000;
T = 1/fs;
figure
plot (k,e)
f_labels ('The vowel ''E''','\it{k}','\it{e(k)}')
f_wait ('Press any key to play sound')
soundsc (e)

% Estimate pitch of speaker

M = 512;
m = 1201:1200+M;
r = f_corr (e(m),e(m),1,0);
figure
plot (0:511,r)
f_labels ('Circular cross-correlation of segment of vowel ''E''','\it{k}','\it{c_{ee}(k)}')
f_wait

% Compute pitch from density spectrum 

S = real(fft(r));
[A,phi,R,f] = f_spec (e(m),M,fs);
figure
n = 1 : M/8;
plot (f(n),S(n),f(n),R(n))
f_labels ('Power density spectrum of segment of vowel ''E''','{\itf (Hz)}','{\itS_N(f)}')
[Smax,imax] = max(S(n));
pitch = f(imax);
hold on 
plot (pitch,Smax,'rs')
fprintf ('\npitch = %.0f Hz\n',pitch)
f_wait
x = cos(2*pi*pitch*k*T);
soundsc (x,fs)
f_wait
