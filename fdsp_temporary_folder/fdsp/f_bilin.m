function [B,A] = f_bilin (b,a,fs)

%F_BILIN: Bilinear analog to digital filter transformation
%
% Usage:       [B,A] = f_bilin (b,a,fs)
%
% Description: Convert an analog filter H(s) = b(s)/a(s) 
%              into a digital filter H(z) = B(z)/A(z) with
%              sampling frequency fs using the bilinear 
%              transformation:
%
%                   2(z-1)
%              s = --------
%                   T(z+1)
%
% Inputs: 
%         b  = vector of length m+1 containing coefficients 
%              of analog numerator polynomial.
%         a  = vector of length n+1 containing coefficients
%              of analog denominator polynomial (n >= m).
%         fs = sampling frequency in Hz
% Outputs: 
%          B = (n+1) by 1 vector containing coefficients of 
%              digital numerator polynomial.
%          A = (n+1) by 1 vector containing coefficients of
%              digital denominator polynomial.
% 
% Notes: The critical frequencies of H(s) must first be 
%        prewarped using:
%
%        F = tan(pi*f*T)/(pi*T)

% Initialize

fs = f_clip (fs,0,fs);
T = 1/fs;

% Find poles and zeros of H(s)

p = roots(a);
z = roots(b);

% Compute poles and zeros of H(z)

n = length(p);
m = length(z);
alpha = (2 + p*T) ./ (2 - p*T);
beta = (2 + z*T) ./ (2 - z*T);
if m < n
   beta(m+1:n) = -1;
end

% Compute gain

b_0 = b(1);
gamma = b_0*(T^(n-m))*prod(2-z*T)/prod(2-p*T);

% Compute coefficient vectors

A = poly(alpha);
B = gamma*poly(beta);
