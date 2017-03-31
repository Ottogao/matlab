function b = f_firls (F,A,m,fs,w)

%F_FIRLS: Design a least-squares FIR filter
%
% Usage: b = f_firls (F,A,m,fs,w)
%
% Inputs: 
%         F = 1 by (p+1) vector containing discrete 
%              frequencies with F(1) = 0 and F(p+1)=fs/2.
%         A  = 1 by (p+1) vector containing samples of
%              desired amplitude response at the discrete
%              frequencies.
% 
%              A(i) = |H_d(F_i)|  
%
%         m   = order of filter (1 <= m <= 2*p)
%         fs  = the sampling frequency in Hz
%         w   = 1 by (p+1) vector containing weighting 
%               factors.  If w is not present, then 
%               uniform weighting is used.
% Outputs: 
%          b   = 1 by m+1 vector of filter coeficients. 
%                The filter output is
%
%                y(k) = b[1]*x[k] + b[2]*x[k-1] + ... + 
%                       b[m+1]*x[k-(m+1)]  
%   
% See also: F_FIRWIN, F_FIRIDEAL, F_FIRSAMP, F_FIRPARKS, 
%           F_FREQZ   

% Initialize

fs = f_clip (fs,0,fs);
p = length(F) - 1;
if (mod(m,2) ~= 0) | (m > 2*p) | (m < 2)
   fprintf ('In f_firls the filter order must be even and the ');
   fprintf ('range 2 <= m <= %d.\n\n',2*p);
   m = f_clip(m,2,2*p);
   m = 2*floor(m/2);
end
if nargin < 5
   w = ones(1,p+1);
end
r = m/2;
T = 1/fs;
 
% Compute coefficient matrix and right-hand side vector

G = zeros(p+1,r+1);
d = zeros(p+1,1);
for i = 0 : p
   d(i+1) = w(i+1)*A(i+1);
   for k = 0 : r
      G(i+1,k+1) = 2*w(i+1)*cos(2*(k-r)*pi*F(i+1)*T);
   end
end

% Find coefficient vector

b = zeros(1,m+1);
c = G \ d;
for i = 0 : r-1
   b(i+1) = c(i+1);
   b(m-i+1) = b(i+1);
end
b(r+1) = 2*c(r+1);
