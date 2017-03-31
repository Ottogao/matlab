% demonstrate sampling jitter in CD
% input: 1kHz sine wave,
% sampling rate: 44.1kHz
% clock jitter: 1ppm-10ppm,
% jitter distribution: uniform/gaussian

clf
clear all
START = 1;  %sampling start time
Fs = 44100; % sampling rate
f = 1000;
TS = 1000;      % time resolution between samples
t=linspace(0,1/f,Fs);  % 2 periods of sine wave, time resolution: 1000pieces/sample
s=sin(2*pi*f*t);
figure(1)
hold on
box on
grid on
plot(t, s);
perfsamp = s(START:TS:length(s));     % take samples
perfsq = round(perfsamp*32768)/32768;   % quantization
qerr = perfsamp - perfsq;               % quantization error
plot((START:TS:length(s))/Fs/TS,perfsamp,'ro');  %plot perfect samples
plot((START:TS:length(s))/Fs/TS,perfsq,'go');    %plot samples after quantization
recon = [];
reconq = [];
for k=1:(length(perfsamp)-1)    %reconstruct signal using linear interpolation
    x = linspace(perfsamp(k),perfsamp(k+1),TS+1);
    recon = [recon x(1:TS)];
    x = linspace(perfsq(k),perfsq(k+1),TS+1);
    reconq = [reconq x(1:TS)];        %reconstruct also the quantized samples
end
plot(t(1:length(recon)),recon, 'm:', t(1:length(reconq)), reconq, 'g:')

LastSP = max(START:TS:length(s));     % mark the last sampling point (time)
LastSV = perfsamp((LastSP-START)/TS+1);
LastSVq = perfsq((LastSP-START)/TS+1);
START = TS-(length(s)-LastSP);        % the first sampling point in next sine cycle

for n=1:100    % continue/repeat sampling for 1000 sine cycles
    perfsamp = s(START:TS:length(s));
    perfsq = round(perfsamp*32768)/32768;
    qerr = perfsamp - perfsq;
    plot((START:TS:length(s))/Fs/TS,perfsamp,'ro');  %plot perfect samples
    plot((START:TS:length(s))/Fs/TS,perfsq,'go');    %plot samples after quantization
    sec1 = linspace(LastSV,perfsamp(1),TS+1);
    sec1q = linspace(LastSVq,perfsq(1),TS+1);
    recon = [sec1((TS-START):(TS-1))];
    reconq = [sec1q((TS-START):(TS-1))];
    for k=1:(length(perfsamp)-1)    %reconstruct signal using linear interpolation
        x = linspace(perfsamp(k),perfsamp(k+1),TS+1);
        recon = [recon x(1:TS)];
        x = linspace(perfsq(k),perfsq(k+1),TS+1);
        reconq = [reconq x(1:TS)];        %reconstruct also the quantized samples
    end
    plot(t(1:length(recon)),recon, 'm:', t(1:length(reconq)), reconq, 'g:')
    LastSP = max(START:TS:length(s));     % mark the last sampling point (time)
    LastSV = perfsamp((LastSP-START)/TS+1);
    LastSVq = perfsq((LastSP-START)/TS+1);
    START = TS-(length(s)-LastSP);        % the first sampling point in next sine cycle
end