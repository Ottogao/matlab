function [B,A] = f_low2bps (b,a,F_0,F_1)

%F_LOW2BPS: Lowpass to bandpass analog transformation
%
% Usage: [B,A] = f_low2bps (b,a,F_0,F_1)
%
% Inputs: 
%         b   = vector of length m+1 containing coefficients
%               of analog numerator polynomial.
%         a   = vector of length n+1 containing coefficients 
%               of analog denominator polynomial (n >= m).
%         F_0 = lower passband cutoff frequency in Hz
%         F_1 = upper passband cutoff frequency in Hz
% Outputs: 
%          B = (m+1) by 1 vector containing coefficients of 
%              bandpass numerator polynomial.
%          A = (n+1) by 1 vector containing coefficients of
%              bandpass denominator polynomial.
%
% See also: F_LOW2LOWS, F_LOW2BSS, F_LOW2HIGHS

% Initialize

F_0 = f_clip (F_0,0,F_0);
F_1 = f_clip (F_1,0,F_1);
Omega_0 = 2*pi*F_0; 
Omega_1 = 2*pi*F_1; 
Omega = Omega_0*Omega_1;
Delta = Omega_1 - Omega_0;
m = length(b) - 1;
n = length(a) - 1;

% Compute poles and zeros

z = roots(b);
r1 = (Delta*z + sqrt(Delta^2*z.^2 - 4*Omega))/2;
r2 = (Delta*z - sqrt(Delta^2*z.^2 - 4*Omega))/2;
r = [r1(:) ; r2(:)];
if n > m
   r(2*m+1:2*m+n-m) = 0;
end
p = roots(a);
q1 = (Delta*p + sqrt(Delta^2*p.^2 - 4*Omega))/2;
q2 = (Delta*p - sqrt(Delta^2*p.^2 - 4*Omega))/2;
q = [q1(:) ; q2(:)];

% Compute gain

b0 = b(1);
beta = b0*(Delta^(n-m));

% Compute coefficients

B = beta*poly(r);
A = poly(q);
