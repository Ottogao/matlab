function [w,e,mu] = f_normlms (x,d,m,alpha,delta,w)

%F_NORMLMS: System identification using normalized LMS method
%
%           y(k) = w(1)x(k) + w(2)x(k-1) + ... + w(m+1)x(k-m)
%
% Usage: [w,e,mu] = f_normlms (x,d,m,alpha,delta,w)
%
% Inputs: 
%         x     = N by 1 vector containing input samples
%         d     = N by 1 vector containing desired output
%                 samples
%         m     = order of transversal filter (m >= 0)
%         alpha = normalized step size (0 to 1)
%         delta = an optional positive scalar controlling
%                 the maximum step size which is mu  = 
%                 alpha/delta. Default: alpha/100
%         w     = an optional (m+1) by 1 vector containing
%                 the initial values of the weights. 
%                 Default: w = 0
% Outputs: 
%          w  = (m+1) by 1 weight vector of filter 
%               coefficients
%          e  = an optional N by 1 vector of errors where 
%               e(k) = d(k)-y(k)
%          mu = an optional N by 1 vector of step sizes 
%
% See also: F_LMS, F_CORRLMS, F_LEAKLMS, F_FXLMS, F_RLS
   
% Initialize

m = f_clip (m,0,m);
N = length(x);
alpha = f_clip (alpha,0,1);
N = length(x);
if (nargin < 5) | (delta == [])
   delta = alpha/100;
   w = zeros(m+1,1);
end
if nargin < 6
   w = zeros(m+1,1);
end
theta = zeros(m+1,1);
e = zeros(N,1);
mu = zeros(N,1); 
q = f_tocol(x);

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = q(k:-1:1);
   else
       theta = q(k:-1:k-m);
   end
   e(k) = d(k) - w'*theta;
   mu(k) = alpha/(delta + theta'*theta);
   w = w + 2*mu(k)*e(k)*theta;
end
