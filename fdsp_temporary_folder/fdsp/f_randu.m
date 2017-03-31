function A = f_randu (m,n,a,b)

%F_RANDU: Construct a uniformly distributed random matrix
%
% Usage: A = f_randu (m,n,a,b)
%
% Inputs: 
%         m = number of rows of A
%         n = number of columns of A
%         a = lower limit of random numbers
%         b = upper limit of random numbers 
% Outputs: 
%          A = m by n matrix of random numbers
%              unformly distributed over [a,b]
%
% See also: F_RANDG, F_RANDINIT

A = a + (b - a)*rand(m,n); 
