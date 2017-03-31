function [p,q,e] = f_sigsyn (x,g,f,f_0,f_s,r,mu)

% F_SIGSYN: Active noise control using signal synthesis method
%
% Usage: [p,q,e] = f_sigsyn (x,g,f,f_0,f_s,r,mu)
%
% Inputs: 
%         x   = N by 1 vector containing input samples
%         g   = n by 1 vector containing coefficients of
%               the primary system.  The desired output is
%               D(z) = G(z)X(z)
%         f   = n by 1 vector containing coefficients of
%               the secondary system.
%         f_0 = fundamental frequency of periodic component
%               of the input in Hz
%         f_s = sampling frequency in Hz 
%         r   = number of harmonics of x(k) it is desired
%               to cancel (1 to f_s/(2*f_0))
%         mu  = step size to use for updating p and q
% Outputs: 
%          p = r by 1 vector of cosine coefficients
%          q = r by 1 vector of sine coefficients 
%          e = an optional N by 1 vector of errors  
%
% See also: F_FXLMS

% Initialize

f = f_tocol(f);
f_s = f_clip (f_s,0,f_s);
f_0 = f_clip (f_0,0,f_s/2);
r_max = floor (f_s/(2*f_0));
r = f_clip (r,1,r_max);
mu = f_clip (mu,0,mu);
N = length(x);
p = zeros(r,1);
q = zeros(r,1);
P = zeros(r,1);
Q = zeros(r,1);
m = length(f)-1;
phi = zeros(m+1,1);
j = [0 : m]';
T = 1/f_s;
psi = 2*pi*f_0*T;
for i = 1 : r
    P(i) = f'*cos(i*j*psi);
    Q(i) = -f'*sin(i*j*psi);
end
e = zeros(N,1);
y = zeros(N,1);
y_hat = zeros(N,1);

% Find optimal set of coeffients

d = filter (g,1,x);
i = [1 : r]';
for k = 1 : N
   y(k) = p'*cos(i*k*psi) + q'*sin(i*k*psi); 
   if k <= m
       phi(1:k) = y(k:-1:1);
   else
       phi = y(k:-1:k-m);
   end
   y_hat(k) = f'*phi;
   e(k) = d(k) - y_hat(k);
   P_old = P;
   P = cos(i*psi) .* P_old - sin(i*psi) .* Q;
   Q = sin(i*psi) .* P_old + cos(i*psi) .* Q;
   p = p + 2*mu*e(k)*P;
   q = q + 2*mu*e(k)*Q;
end
