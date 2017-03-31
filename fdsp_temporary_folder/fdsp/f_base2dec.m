function i = f_base2dec (q,d)

% F_BASE2DEC: Convert a base d array to a decimal integer
%
% Usage: i = f_base2dec (q,d)
%
% Inputs: 
%         q = p by 1 array of base d numbers 
%         d = base of number system (d >= 2)
% Outputs: 
%          i = decimal equivalent of q
%
% See also: BASE2DEC, DEC2BAS

p = length(q);
i = q(p);
for j = p-1 : -1 : 1
    i = d*i + q(j);
end
