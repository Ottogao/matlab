function [B,A] = f_low2lows (b,a,F_0)

%F_LOW2LOWS: Lowpass to lowpass analog transformation
%
% Usage: [B,A] = f_low2lows (b,a,F_0)
%
% Inputs: 
%         b   = vector of length m+1 containing coefficients
%               of analog numerator polynomial.
%         a   = vector of length n+1 containing coefficients
%               of analog denominator polynomial (n >= m).
%         F_0 = lowpass cutoff frequency in Hz
% Outputs: 
%          B = (m+1) by 1 vector containing coefficients of
%              lowpass numerator polynomial.
%          A = (n+1) by 1 vector containing coefficients of
%              lowpass denominator polynomial.
%
% See also: F_LOW2HIGHS, F_LOW2BPS, F_LOW2BSS

% Initialize

F_0 = f_clip (F_0,0,F_0);
Omega_0 = 2*pi*F_0; 
m = length(b) - 1;
n = length(a) - 1;

% Compute poles, zeros, and gain

z = Omega_0*roots(b);
p = Omega_0*roots(a);
b0 = b(1);

% Compute coefficients

B = b0*(Omega_0^(n-m))*poly(z);
A = poly(p);
  