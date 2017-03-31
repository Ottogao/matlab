function [H,f] = f_freq (b,a,N,fs)

%F_FREQ: Compute exact frequency response of discrete-time system
%
%                b(1) + b(2)z^(-1) + ...+ b(M+1)z^(-m)
%         H(z) = --------------------------------------
%                a(1) + a(2)z^(-1) + ... + a(N+1)z^(-n)  
%
% Usage: [H,f] =f_freqz (b,a,N,fs,bits,realize);
%
% Inputs: 
%         b       = numerator polynomial coefficient vector 
%         a       = denominator polynomial coefficient vector
%         N       = number of discrete frequencies 
%         fs      = sampling frequency (default = 1)
% Outputs: 
%          H = 1 by N complex vector containing discrete
%               frequency response
%          f = 1 by N vector containing discrete 
%              frequencies at which H is evaluated
% Notes: 
%        1. The frequency response is evaluated  along the
%           top half of the unit circle.  Thus f ranges 
%           from 0 to (N-1)fs/(2N).
%
%        2. H(z) must be stable.  Thus the roots of a(z) must
%           lie inside the unit circle. 
%
% See also: F_FREQS, F_FREQZ

% Initialize

if (nargin < 4) | (isempty(fs) == 1)
    fs = 1;
end
T = 1/fs;
H = zeros(1,N);
f = linspace(0,(N-1)*fs/(2*N),N);
r = max(abs(roots(a)));
if r >= 1
   fprintf ('\nThe filter in f_freq is not stable.\n')
   return
end

% Compute frequency response using definition

f = linspace(0,(N-1)*fs/(2*N),N);
z1 = exp(-j*2*pi*f*T);
H = polyval (b,z1) ./ polyval (a,z1);
H = f_torow(H);    
