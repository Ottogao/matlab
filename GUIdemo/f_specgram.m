function [G,f,t] = f_specgram (x,L,fs,win)

%F_SPECGRAM: Compute spectrogram of a signal
%
% Usage: [G,f,t] = f_specgram (x,L,fs,win)
%
% Inputs: 
%         x   = vector of length N samples
%         L   = subsequence length
%         fs  = sampling freqeuncy
%         win = window type (0 to 4, see Table 3.8.1 of text)
% Outputs: 
%          G = (2M-1) by L matrix containing spectrogram
%          f = vector of length L/2 containing frequency values
%          t = vector of length 2M-1 containting time values
%
% See also: F_SPEC, F_PDS

% Initialize

N = length(x);
f = linspace (0,(L-1)*fs/L,L);
T = 1/fs;
M = floor(N/L);
t = linspace (0,(2*M-2)*L*T/2,2*M-1);
G = zeros(2*M-1,L);
xm = zeros(1,L);

% Compute spectrogram

w = f_window (win,L); 
w(L+1) = [];

h = waitbar (0,'Computing Spectrogram');
for m = 1 : 2*M-1
    waitbar (m/(2*M-1),h)
    k = 1 + (m-1)*L/2;
    xm = f_torow(x(k : k+L-1));
    G(m,:) = abs(fft(w .* xm));
end
close (h);
