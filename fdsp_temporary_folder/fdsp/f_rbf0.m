function y = f_rbf0 (x,w,a,b,m,n,d)

% F_RBF0: Compute output of raised-cosine RBF network
%
% Usage: y = f_rbf0 (x,w,a,b,m,n,d)
%
% Inputs: 
%         x = N by 1 vector of inputs
%         w = r by 1 weight vector  
%         a = 2 by 1 vector of input bounds
%         b = 2 by 1 vector of output bounds
%         m = number of past inputs (m >= 0)
%         n = number of past outputs (n >= 0)
%         d = number of grid points per dimension (d >= 2)
% Outputs: 
%          y = N by 1 vector of outputs.
% Notes: 
%        1. r = d^p where p = m+n+1;  
%        2. if b(1)*b(2) > 0 the initial condition is
%           set to y(1:n) = (b(1)+b(2))2.  Otherwise,
%           y(1:n) = 0;
%
% See also: F_RBF1, F_RBFW, F_RBFV

% Initialize

m = f_clip (m,0,m);
n = f_clip (n,0,n);
d = f_clip (d,2,d);
p = m + n + 1;
N = length(x);
M = 2^p;
y = zeros(size(x));
if b(1)*b(2) > 0
    y(1:n) = (b(1)+b(2))/2;           % start inside domain Theta
end
theta = zeros(p,1);
Vert = zeros(p,M);

% Evaluate y

h = waitbar (0,'Computing RBF outputs');
for k = 1 : N
    waitbar (k/N,h);
    theta = f_state(x,y,k,m,n);
    [index,Vert] = f_neighbors (theta,a,b,m,n,d);
    for j = 1 : M
        s = index(j)+1;
        z = f_rbfg (theta-Vert(:,j),a,b,m,n,d);
        y(k) = y(k) + w(s)*z;
    end
end
close(h)
