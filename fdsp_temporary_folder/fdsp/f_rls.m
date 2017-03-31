function [w,e] = f_rls (x,d,m,gamma,delta,w)

%F_RLS: System identification using RLS method
%
%       y(k) = w(1)x(k) + w(2)x(k-1) + ... + w(m+1)x(k-m)
%
% Usage: [w,e] = f_lms (x,d,m,gamma,delta,w)
%
%
% Inputs: 
%         x      = N by 1 vector containing input samples
%         d      = N by 1 vector containing desired output
%                  samples
%         m      = order of transversal filter (m >= 0)
%         gamma  = forgetting factor (0 to 1)
%         delta  = optional regularization parameter 
%                  (delta > 0). Default P_x
%         w      = optional initial values of the weights.
%                  Default: w = 0
% Outputs: 
%          w = (m+1) by 1 weight vector of filter 
%              coefficients
%          e = an optional N by 1 vector of errors where 
%              e(k) = d(k)-y(k)
%
% Note: As the SNR of x decreases, delta should be 
%       increased.
%
% See also: F_LMS, F_NORMLMA, F_CORRLMS, F_LEAKLMS, F_FXLMS
   
% Initialize

m = f_clip (m,0,m);
N = length(x);
gamma  = f_clip (gamma,eps,1);
if (nargin > 4) & (delta ~= [])
    delta = f_clip (delta,eps,delta);
else
    delta = sum(x.^2)/N;
end
if nargin < 6
    w =  zeros(m+1,1);
end
if nargout > 1
   e = zeros(N,1);
end
theta = zeros(m+1,1);
Q = (1/delta)*eye(m+1,m+1);
p = zeros(m+1,1);
r = zeros(m+1,1);
q = f_tocol (x);

% Find optimal weight vector

for k = 1 : N
   if k < (m+1)
       theta(1:k) = q(k:-1:1);
   else
       theta(1:m+1) = q(k:-1:k-m);
   end
   r = Q*theta;
   c = gamma + theta'*r;
   p = gamma*p + d(k)*theta;
   Q = (1/gamma)*(Q - r*r'/c);
   w = Q*p;
   if nargout > 1
       e(k) = d(k) - w'*theta;
   end

end
