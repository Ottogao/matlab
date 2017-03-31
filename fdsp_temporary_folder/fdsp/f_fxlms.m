function [w,e] = f_fxlms (x,g,f,m,mu,w)

% F_FXLMS: System identification using filtered-x LMS method
%
% Usage:  [w,e] = f_fxlms (x,g,f,m,mu,w)
%
% Inputs: 
%         x  = N by 1 vector containing input samples
%         g  = n by 1 vector containing coefficients of
%              the primary system.  The desired output 
%              is D(z) = G(z)X(z)
%         f  = n by 1 vector containing coefficients of
%              the secondary system.
%         m  = order of transversal filter (m >= 0)
%         mu = step size to use for updating w
%         w  = an optional (m+1) by 1 vector containing
%              the initial values of the weights. Default:
%              w = 0
% Outputs: 
%          w = (m+1) by 1 weight vector of filter
%              coefficients
%          e = an optional N by 1 vector of errors  
%
% Notes: Typically mu << 1/[(m+1)*P_x'] where P_x' is the  
%        average power of filtered input X'(z) = F(z)X(z).
%
% See also: F_LMS, F_NORMLMS, F_CORRLMS, F_LEAKLMS, F_RLS

% Initialize

m = f_clip (m,0,m);
mu = f_clip (mu,0,mu);
N = length(x);
if nargin < 6
   w = zeros(m+1,1);
end
theta = zeros(m+1,1);
theta_hat = zeros(m+1,1);
n = length(f);
phi = zeros(n,1);
e = zeros(N,1);
y = zeros(N,1);
y_hat = zeros(N,1);

% Compute filtered input and desired output

x_hat = filter (f,1,x);
d = filter (g,1,x);

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = x(k:-1:1);
       theta_hat(1:k) = x_hat(k:-1:1);
   else
       theta = x(k:-1:k-m);
       theta_hat = x_hat(k:-1:k-m);
   end
   y(k) = w'*theta;
   if k < n
       phi(1:k) = y(k:-1:1);
   else
       phi = y(k:-1:k-(n-1));
   end
   y_hat(k) = f'*phi;
   e(k) = d(k) - y_hat(k);
   w = w + 2*mu*e(k)*theta_hat;
end
