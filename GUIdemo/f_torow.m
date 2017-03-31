function y = f_torow (x)

%F_TOROW: Convert to a row vector
%
% Usage: y = f_torow (x)
%
% Inputs: 
%         x = input vector or matrix
% Outputs: 
%          y = row vector containing elements of x

y = x(:).';             % just ' is Hermetian transpose!
  