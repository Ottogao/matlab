function [w,e] = f_lms (x,d,m,mu,w)

%F_LMS: System identification using least mean square method
%
%       y(k) = w(1)x(k) + w(2)x(k-1) + ... + w(m+1)x(k-m)
%
% Usage: [w,e] = f_lms (x,d,m,mu,w)
%
% Inputs: 
%         x    = N by 1 vector containing input samples
%         d    = N by 1 vector containing desired output
%                samples
%         m    = order of transversal filter (m >= 0)
%         mu   = step size to use for updating w
%         w    = an optional (m+1) by 1 vector containing
%                the initial values of the weights. 
%                Default: w = 0
% Outputs: 
%          w = (m+1) by 1 weight vector of filter 
%              coefficients
%          e = an optional N by 1 vector of errors where 
%              e(k) = d(k)-y(k)
%
% Notes: Typically mu << 1/[(m+1)*P_x] where P_x is the  
%        average power of input x.
%
% See also: F_NORMLMS, F_CORRLMS, F_LEAKLMS, F_FXLMS,
%           F_RLS
   
% Initialize

m = f_clip (m,0,m);
mu = f_clip (mu,0,mu);
N = length(x);
if nargin < 5
   w = zeros(m+1,1);
end
theta = zeros(m+1,1);
e = zeros(size(x));
q = f_tocol(x); 

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = q(k:-1:1);
   else
       theta = q(k:-1:k-m);
   end
   e(k) = d(k) - w'*theta;
   w = w + 2*mu*e(k)*theta;
end
%-----------------------------------------------------------------------
