function [A,phi,S,f] = f_spec (x,N,fs)

%F_SPEC: Compute magnitude, phase, and power density spectra
%
% Usage: [A,phi,S,f] = f_spec (x,N,fs);
%
% Inputs: 
%         x  = vector of length M containing signal samples 
%         N  = optional integer specifying number of points
%              in spectra (default M). If N > M, then N-M 
%              zeros are padded to x.
%         fs = optional sampling frequency in Hz (default 1)
% Outputs: 
%          A   = vector of length N containing mangitude 
%                spectrum
%          phi = vector of length N containing phase spectrum 
%                in radians
%          S   = vector of length N containing power density 
%                 spectrum
%          f   = vector of length N containing discrete 
%                frequencies at which the spectra are 
%                evaluated: 0 <= f(i) <= (N-1)*fs/N.
%
% See also: F_PDS, F_SPECGRAM

% Initialize

if nargin < 3
   fs = 1;
end
if (nargin < 2) & isempty(N)
   N = length(x);
end

% Compute spectra

f = linspace (0,(N-1)*fs/N,N);
if size(x,1) > size(x,2)
   f = f';
end
X = fft (x,N);
A = abs(X);
phi = angle(X);
S = (A .^ 2)/N; 
