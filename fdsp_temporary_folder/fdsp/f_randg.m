function A = f_randg (m,n,mu,sigma)

%F_RANDG: Construct Gaussian random matrix
%
% Usage: A = f_randg (m,n,mu,sigma)
%
% Inputs: 
%         m     = number of rows of A
%         n     = number of columns of A
%         mu    = mean of random numbers
%         sigma = standard deviation of random numbers 
% Outputs: 
%          A = m by n matrix of Gaussian random numbers
%              with mean mu and standard deviation sigma
%
% See also: F_RANDU, F_RANDINIT

x1 = f_randu (m,n,0,1);
x2 = f_randu (m,n,0,1);
A = sqrt(-2*log(x1)).*cos(2*pi*x2);
A = sigma*(A - mu);
