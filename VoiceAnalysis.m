% Voice analysis using Fast Fourier Transform
% made by Chao Gao, 2010
%
% Purpose: a syllable is recorded and analyzed by FFT
% a syllable is often made up of a syllable nuclear (vowel) with optional
% initiail and final margins (consonants)
clf;
Fs = 8000;
Dur = 1;
t=linspace(0,Fs,Fs*Dur);
vowels = ['a'; 'e'; 'i'; 'o'; 'u'];
pstyle = ['b'; 'm'; 'r'; 'g'; 'y'];
figure(1)
hold on
for k=1:5
    d=warndlg(sprintf('Say %c in %d second', vowels(k),Dur));
    waitfor(d);
    rec = wavrecord(Fs*Dur, Fs);
    frq = fft(rec);

    plot(t(1:Fs/2), abs(frq(1:Fs/2))+(k-1)*10, pstyle(k))
end
legend(vowels);
xlabel('Frequency (Hz)');
ylabel('Amplitude (dB)');
hold off