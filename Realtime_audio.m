%test real-time audio processing
clear all
clf
SamplesPerFrame = 2048;
Fs = 44100;
Mic1 = dsp.AudioRecorder('DeviceName','Default','SamplesPerFrame', SamplesPerFrame,'NumChannels',1);
%Mic2 = dsp.AudioRecorder('DeviceName','Line In (High Definition Audio Device)','SamplesPerFrame', SamplesPerFrame,'NumChannels',1);
%Spectra = dsp.SpectrumAnalyzer('SampleRate', Fs);
%TimeScope = dsp.TimeScope('SampleRate', Fs, 'BufferLength', 2*Fs, 'TimeSpan',SamplesPerFrame/Fs,'ShowGrid', true);
audioIn1 = [];  % audioIn2 = audioIn1;
RMS = [];
figure(1); 
tic;
while toc < 10
    stepIn1 = step(Mic1);
    audioIn1 = [audioIn1; stepIn1];
    rms1 = sum(stepIn1.*stepIn1);
    RMS = [RMS; rms1];
%     stepIn2 = step(Mic2);
%     audioIn2 = [audioIn2; stepIn2];
%     rms2 = sum(stepIn2.*stepIn2);
    figure(1);
    clf
    box on; axis([-1 1 -1 1]); axis off; axis image;
    text(0, 0, sprintf('%.3f', 10*log10(rms1)+60), 'FontSize', 48, 'HorizontalAlignment', 'center');
    %step(Spectra, audioIn);
    %step(TimeScope, audioIn);
end
release(Mic1); %release(Mic2);
%release(Spectra);
N = length(audioIn1);
R = length(RMS);
t = (0:(N-1))/Fs;
trms = (0:(R-1))/(Fs/SamplesPerFrame);
figure(2); subplot(2,1,1); plot(t, audioIn1); title('Realtime sound');
subplot(2,1,2); plot(trms, (RMS)); title('RMS of 2048 samples');
sound(audioIn1, Fs);