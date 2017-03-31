function [b,a,e] = f_identify (u,y,m,n)

%F_IDENTIFY: Identify IIR model using least squares fit
%
%            Y(z)   b(1) + b(2)z^(-1) + ... + b(m+1)z^(-(m+1))
%            ---- = ------------------------------------------
%            U(z)   a(1) + a(2)z^(-1) + ... + a(n+1)z^(-(n+1))   
%
% Usage: [b,a,e] = f_identify (u,y,n,m)
%
% Inputs: 
%         u = p by 1 vector containing input samples
%         y = p by 1 vector containing output samples
%         m = number of zeros (m >= 0)
%         n = number of poles (n >= 0)
% Outputs: 
%          b = 1 by (m+1) vector of numerator coefficients
%          a = 1 by (n+1) vector of denominator coefficients
%              with a(1) = 1.
%          e = least squares error
%            
% Notes: The input u must be rich in frequency content:
%        the magnitude spectrum must be nonzero at at
%        least p frequencies 
   
% Initialize

n = f_clip (n,0,n);
m = f_clip (m,0,m);
a = [1 zeros(1,n)];
b = zeros(1,m+1);
e = 0;
q = n + m + 1;
p = length(u);
if length(y) ~= p
   fprintf ('Arguments 1 and 2 of f_getarma must be of the same length.')
   f_wait
   return
end
if p < q
   fprintf ('Insufficient number of samples in f_getarma.')
   f_wait
   return
end 
X = zeros (p,q);
  
% Compute state matrix X

for i = 1 : p
   for j = 1 : n
      if j < i
         X(i,j) = -y(i-j);
      end
   end 
   for j = 0 : m
      if j < i
         X(i,n+1+j) = u(i-j);
      end
   end
end

% Compute the least-squares estimate, theta  

if rank(X) < q
   fprintf ('Insufficient frequency content in input signal for f_getarma.')
   f_wait
   return
end
theta = X \ y;
E = X*theta-y;
e = E'*E;

% Extract a and b
 
a = [1 theta(1:n)'];
b = theta(n+1:q)';
