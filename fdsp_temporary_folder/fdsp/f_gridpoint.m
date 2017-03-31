function theta = f_gridpoint (i,a,b,m,n,d)

% F_GRIDPOINT: Find grid point in domain of F_RBF0
%
% Usage: theta = f_gridpoint (i,a,b,m,n,d)
%
% Inputs: 
%         i = scalar index of grid point
%         a = 2 by 1 vector of input bounds
%         b = 2 by 1 vector of output bounds
%         m = number of past inputs (m >= 0)
%         n = number of past outputs (n >= 0)
%         d = number of grid points per dimension (d >= 2)
% Outputs: 
%          theta = p by 1 vector corresponding to ith grid
%                  point.  Here p = m+n+1
%
% See also: F_RBF0, F_RBF1, F_RBFW, F_RBFV

% Initialize

m = f_clip (m,0,m);
n = f_clip (n,0,n);
d = f_clip (d,2,d);
p = m + n + 1;
theta = zeros(p,1);

% Compute grid point i

q = f_dec2base (i,d,p);
Delta_x = (a(2) - a(1))/(d-1);
Delta_y = (b(2) - b(1))/(d-1);
for j = 1 : p
    if j <= (m+1)
        theta(j) = a(1) + q(j)*Delta_x;
    else
        theta(j) = b(1) + q(j)*Delta_y;
    end
end
 