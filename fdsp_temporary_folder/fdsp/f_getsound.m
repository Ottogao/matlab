function [x,cancel] = f_getsound (x,duration,fs,xstr);

%F_GETSOUND: Record sound from PC microphone
%
% Usage: [x,cancel] = f_getsound (x,duration,fs,xstr);
%
% Inputs: 
%         x        = an array containing the original samples
%         duration = length of recording in seconds (0 to 10)
%         fs       = sampling frequency in Hz (default 8000)
%         xstr     = optional string specifying the array name  
%                    to use in the prompt string
% Outputs: 
%          x      = an array of length N containing the  
%                   microphone samples, N = floor(duration*fs)
%          cancel = true if cancel button is clicked
%
% Notes: This function requires a Windows PC.
%
% See also: SOUNDSC

% Initialize

channels = 1;
dtype = 'double';
seconds = f_clip (duration,0,10);
if nargin < 3
    fs = 8000;            % 8000, 11025, 22050, 44100
end
if nargin < 4
    xstr = inputname(1);
end

% Record the sound

cancel = 0;
N = floor(seconds*fs);
caption = sprintf ('Click Start to begin recording %.1f seconds of microphone data in %s.',...
                    seconds,xstr);
choice = questdlg (caption,'Recorded Input','Start','Cancel','Start');
if strcmp(choice,'Start')
    x = wavrecord (N,fs,channels,dtype);
else
    cancel = 1;
end

 