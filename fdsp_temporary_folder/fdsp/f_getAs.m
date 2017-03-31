function [As,f] = f_getAs (b,a,fs,eps)

%_GETAS: Estimate stopband attenuation in dB of a lowpass filter
%
% Usage: [As,f] = f_getAs (b,a,fs,eps)
%
% Inputs: 
%         b   = 1 by m+1 array containing the numerator coefficients
%         a   = 1 by n+1 array containing the denominator coefficients
%         fs  = sampling frequency
%         eps = threshold used for determining the first zero in dB
% Outputs: 
%          As = the stopband attenuation in dB:
%
%               As = -20log10(delta_s)
%
%          f  = frequency at which maximum stopband attenuation 
%                   occurs 
%
% Notes: This function only works with a lowpass filter with zeros
%        on the unit circle.  

% Initialize

N = 1000;

% Compute magnitude response

[H,f] = f_freqz(b,a,N,fs);
A = 20*log10(abs(H));

% Estimate As

k = 0;
for i = 1 : N
   if A(i) < -eps
      k = i;
      break
   end
end
if k > 0
   [ripple,kmax] = max(A(k:N));
   As = -ripple;
   f = (k+kmax-1)*(fs/2)/N;
else
   As = 0;
   f = 0;
end
