function [b,a] = f_butters (F_p,F_s,delta_p,delta_s,n)

%F_BUTTERS: Design lowpass analog Butterworth filter
%
%                                     b(1)
%              H(s) = ------------------------------------
%                     a(1)s^n + a(2)s^(n-1) + ... + a(n+1)
%
% Usage: [b,a] = f_butters (F_p,F_s,delta_p,delta_s,n)
%
% Inputs: 
%        F_p     = passband cutoff frequency in Hz
%        F_s     = stopband cutoff frequency in Hz 
%                  (F_s > F_p)
%        delta_p = passband ripple
%        delta_s = stopband attenuation
%        n       = an optional integer specifying the filter
%                  order.  If n is not present, the smallest
%                  order which meets the specifications is
%                  used.
% Outputs:  
%          b = numerator coefficient 
%          a = 1 by (n+1) coefficient vector of denominator 
%          polynomial 
%
% See also: F_CHEBY1S, F_CHEBY2S, F_ELLIPTICS

% Initialize

F_p = f_clip (F_p,0,F_p);
F_s = f_clip (F_s,F_p,F_s);
delta_p = f_clip (delta_p,0,delta_p);
delta_s = f_clip (delta_s,0,delta_s);

% Find order and cutoff frequency

r = F_p/F_s;
d = sqrt(((1-delta_p)^(-2)-1)/(delta_s^(-2)-1));
if nargin < 5
   n = ceil(log(d)/log(r));
end
n = f_clip(n,1,n);
F_c = F_p/(((1-delta_p)^(-2)-1)^(1/(2*n)));   % meet passband spec exactly
Omega_c = 2*pi*F_c;

% Find poles

k = 0 : n-1;
theta = pi*(2*k+1+n)/(2*n);
p = Omega_c*exp(j*theta);

% Find coefficients

b = Omega_c^n;
a = real(poly(p));

