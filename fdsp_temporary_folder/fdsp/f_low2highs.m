function [B,A] = f_low2highs (b,a,F_0)

%F_LOW2HIGHS: Lowpass to highpass analog transformation
%
% Usage: [B,A] = f_low2highs (b,a,F_0)
%
% Inputs: 
%         b   = vector of length m+1 containing coefficients
%               of analog numerator polynomial.
%         a   = vector of length n+1 containing coefficients
%               of analog denominator polynomial (n >= m).
%         F_0 = highpass cutoff frequency in Hz
% Outputs: 
%          B = (m+1) by 1 vector containing coefficients of
%              highpass numerator polynomial.
%          A = (n+1) by 1 vector containing coefficients of
%              highpass denominator polynomial.
%
% See also: F_LOW2LOWS, F_LOW2BPS, F_LOW2BSS

% Initialize

F_0 = f_clip (F_0,0,F_0);
Omega_0 = 2*pi*F_0; 
m = length(b) - 1;
n = length(a) - 1;

% Compute poles and zeros

z0 = roots(b);
z = Omega_0 ./ z0;
if n > m
   z(m+1:n) = 0;
end
p0 = roots(a);
p = Omega_0 ./ p0;

% Compute gain

b0 = b(1);
beta = real(b0*((-1)^(n-m))*prod(z0)/prod(p0));

% Compute coefficients

B = beta*poly(z);
A = poly(p);
  