function q = f_dec2base (i,d,p)

% F_DEC2BASE: Convert a decimal integer to a base d array
%
% Usage: q = f_dec2base (i,d,p)
%
% Inputs: 
%         i = decimal integer (0 to d^p - 1) 
%         d = base of number system (d >= 2)
%         p = number of base d digits (p >= 1)
% Outputs: 
%          q = p by 1 array of base d numbers.
%
% See also: F_BASE2DEC, DEC2BASE, BASE2DEC

s = d^(p-1);
q = zeros(p,1);
for j = p : -1 : 2
   q(j) = floor(i/s);
   i = i - q(j)*s;
   s = s/d;
end
q(1) = i;
