function [w,e,mu] = f_corrlms (x,d,m,alpha,beta,w)

%F_CORRLMS: System identification using correlation LMS method.
%
%           y(k) = w(1)x(k) + w(2)x(k-1) + ... + w(m+1)x(k-m)
%
% Usage: [w,e,mu] = f_corrlms (x,d,m,alpha,beta,w)
%
% Inputs: 
%         x     = N by 1 vector containing input samples
%         d     = N by 1 vector containing desired output
%                 samples
%         m     = order of transversal filter (m >= 0)
%         alpha = scalar containing relative step size
%         beta  = an scalar containing the smoothing
%                 parameter. beta is approximately one 
%                 with 0 < beta < 1. Default: 1 - 0.5/(m+1)
%         w     = an optional (m+1) by 1 vector containing
%                 the initial values of the weights.
%                 Default: w = 0
% Outputs: 
%          w  = (m+1) by 1 weight vector of filter 
%               coefficients
%          e  = an optional N by 1 vector of errors where 
%               e(k) = d(k)-y(k)
%          mu = an optional N by 1 vector containing step
%               sizes  
%
% See also: F_LMS, F_NORMLMS, F_LEAKLMS, F_FXLMS, F_RLS
   
% Initialize

m = f_clip (m,0,m);
N = length(x);
if (nargin < 5) | (beta == [])
   beta = 1 - 0.5/(m+1);
   w = zeros (m+1,1);
end
if nargin < 6
   w = zeros (m+1,1);
end
theta = zeros(m+1,1);
e = zeros(N,1);
mu = zeros(N,1); 
q = f_tocol (x);

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = q(k:-1:1);
   else
       theta = q(k:-1:k-m);
   end
   e(k) = d(k) - w'*theta;
   if k == 1
       r = (1 - beta)*e(k)*x(k);
   else
       r = beta*r + (1 - beta)*e(k)*x(k);
   end
   mu(k) = alpha*abs(r);
   w = w + 2*mu(k)*e(k)*theta;
end
 