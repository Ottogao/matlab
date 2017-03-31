function y = f_chebpoly (x,n)

%F_CHEBPOLY: Evaluate Chebychev polynomial of first kind
%
% Usage: y = f_chebpoly (x,n)
%
% Inputs: 
%         x = evaluation point
%         n = polynomial degree (n >= 0)
% Outputs: 
%          y = nth Chebyshev polynomial of first kind 
%              evaluated at x.  y = T_n(x).

n = max (n,0);
if (abs(x) <= 1)
    y = cos(n*acos(x));
else
    y = cosh(n*acosh(x));
end
