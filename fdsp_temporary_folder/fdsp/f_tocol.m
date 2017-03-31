function y = f_tocol (x)

%F_TOCOL: Convert to a column vector
%
% Usage: y = f_tocol (x)
%
% Inputs: 
%         x = input vector or matrix
% Outputs: 
%          y = column vector containing elements of x

y = x(:);
  