clear all
clf
a = audiodevinfo();
FS = 8000;
numDev = length(a.input);
SamplesPerFrame = 256;
% line-in input has some problems (in resume(obj) of record()), try dsp
% toolbox
Mic1 = dsp.AudioRecorder('DeviceName','default',...
    'SampleRate', FS, 'NumChannels',1,'SamplesPerFrame', SamplesPerFrame);
Mic2 = dsp.AudioRecorder('DeviceName','Line In (High Definition Audio Device)',...
    'SampleRate', FS, 'NumChannels',1,'SamplesPerFrame', SamplesPerFrame);

audio1 = [];
audio2 = [];
rms1 = []; rms2 = [];
figure(1); 
tic
while toc < 10
    stepin1 = step(Mic1);   stepin2 = step(Mic2);
    audio1 = [audio1; stepin1]; audio2 = [audio2; stepin1];
    r1 = rms(stepin1); r2 = rms(stepin2);
    rms1 = [rms1; r1]; rms2 = [rms2 r2];
    figure(1);
    clf; box on; axis([-1 1 -1 1]); axis off; axis image;
    text(0,0,sprintf('%.3f  %.3f',10*log10(r1),10*log10(r2)),...
        'FontSize', 48, 'HorizontalAlignment', 'center');
end
release(Mic1);
release(Mic2);
figure(2)
rlen = length(rms1);
rt = (0:(rlen-1))/(44100/SamplesPerFrame);
plot(rt, rms1, rt, rms2);
legend('Your beat','Music');