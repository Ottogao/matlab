function b = f_firsamp (A,m,fs,sym)

%F_FIRSAMP: Design a frequency-sampled FIR filter
%
% Usage: b = f_firsamp (A,m,fs,sym)
%
% Inputs: 
%         A   = 1 by floor(m/2)+1 array containing the 
%               samples of the desired amplitude response.
%
%               |A(i)| = |H(f_i)|  
%
%               Here the ith discrete frequency is
%
%               f_i = (i-1)fs/(m+1)
%
%               where fs is the sampling frequency.
%         m   = order of filter
%         fs  = the sampling frequency in Hz
%         sym = symmetry of pulse response.  
%
%               0 = even symmetry of h(k) about k = m/2
%               1 = odd symmetry of h(k) about k = m/2
% Outputs: 
%          b   = 1 by m+1 vector of filter coeficients. 
%                The filter output is
%
%                y(k) = b[1]*x[k] + b[2]*x[k-1] + ... + 
%                       b[m+1]*x[k-(m+1)]  
% Notes: 
%        1. The linear-phase filter type is determined by
%           combination of sym and n:
%
%            sym    n      type
%             0    even     1
%             0    odd      2
%             1    even     3
%             1    odd      4
%
%        2. To get maximum stopband attenuation, there 
%           should be some samples in the transition band 
%           and their values should be optimized. 
%
% See also: F_FIRWIN, F_FIRIDEAL, F_FIRLS, F_FIRPARKS, 
%           F_FREQZ   

% Initialize

m = f_clip(m,1,m);
N = m+1;
T = 1/fs;
if sym == 0
   b = (A(1)/N)*ones(1,N);
else
   b = zeros(1,N);
end

% Compute coefficients

for k = 0 : m
   for i = 1 : floor(m/2)
      if sym == 0
         b(k+1) = b(k+1) + (2/N)*A(i+1)*cos(2*pi*i*(k-0.5*m)/N);
      else
         b(k+1) = b(k+1) - (2/N)*A(i+1)*sin(2*pi*i*(k-0.5*m)/N);
      end
   end
end
