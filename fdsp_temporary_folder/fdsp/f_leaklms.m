function [w,e] = f_leaklms (x,d,m,mu,nu,w)

%F_LEAKLMS: System identificatoin using leaky LMS method
%
%           y(k) = w(1)x(k) + w(2)x(k-1) + ... + w(m+1)x(k-m)
%
% Usage: [w,e] = f_leaklms (x,d,m,mu,nu,w)
%
% Inputs: 
%         x    = N by 1 vector containing input samples
%         d    = N by 1 vector containing desired output samples
%         m    = order of transversal filter (m >= 0)
%         mu   = step size to use for updating w
%         nu   = an optional leakage factor in the range 0 to 1.
%                Pick nu = 1 - 2*mu*gamma where gamma << 0.5.
%               (default: 1 - 0.1*mu).
%         w    = an optional (m+1) by 1 vector containing the
%                initial values of the weights (default: w = 0)
% Outputs: 
%          w = (m+1) by 1 weight vector of filter coefficients
%          e = an optioinal N by 1 vector of errors where 
%              e(k) = d(k)-y(k)
%
% Notes: 
%        1. When nu = 1, the leaky LMS method reduces to the basic
%           LMS method.
%        2. Typically mu << 1/[(m+1)*P_x] where P_x is the  
%           average power of input x.
%
% See also: F_LMS, F_NORMLMS, F_CORRLMS, F_FXLMS, F_RLS

% Initialize

m = f_clip (m,0,m);
mu = f_clip (mu,0,mu);
if nu ~= []
   nu = f_clip (nu,0,1);
end
N = length(x);
if (nargin < 5) | (nu == [])
   nu = 1 - 0.5*mu;
   w = zeros (m+1,1);
end
if nargin < 6
   w = zeros (m+1,1);
end
theta = zeros(m+1,1);
e = zeros(N,1);
q = f_tocol(x);

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = q(k:-1:1);
   else
       theta = q(k:-1:k-m);
   end
   e(k) = d(k) - w'*theta;
   w = nu*w + 2*mu*e(k)*theta;
end
