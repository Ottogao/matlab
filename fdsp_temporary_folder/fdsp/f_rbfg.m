function y = f_rbfg (theta,a,b,m,n,d)

% F_RBFCOS: Compute raised-cosine RBF function
%
% Usage: y = f_rbfg (theta,a,b,m,n,d)
%
% Entry: 
%        theta = an p by 1 vector specifiying the evaluation
%                point where p = m+n+1
%        a     = a 2 by 1 vector of bounds on the input
%        b     = a 2 by 1 vector of bounds on the ouput
%        m     = the number of past inputs (m >= 0)
%        n     = the number of past ouputs (n >= 0)
%        d     = the number of grid points per dimension
%                (d >= 2) 
% Outputs: 
%          y = g(theta)
%
% See also: F_RBF0, F_RBF1

% Initialize

m = f_clip (m,0,m);
n = f_clip (n,0,n);
d = f_clip (d,2,d);
p = length(theta);
if p ~= (m+n+1)
    fprintf ('In function f_rbfg, length(theta) ~= m+n+1.\n')
    y = 0;
    return
end

% Compute y

Delta_x = (a(2) - a(1))/(d-1);
Delta_y = (b(2) - b(1))/(d-1); 
y = 1;
for i = 1 : p
    if i <= m+1
        y = y*G_0(theta(i)/Delta_x);
    else
        y = y*G_0(theta(i)/Delta_y);
    end
end

function y = G_0(z)

% Scalar raised-cosine RBF

if abs(z) <= 1
    y = (1 + cos(pi*z))/2;
else
    y = 0;
end
