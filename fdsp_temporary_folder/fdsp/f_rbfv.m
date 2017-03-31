function [w,V,e] = f_rbfv (f,N,a,b,m,n,d,mu,ic,w,V)

% F_RBFW: Identify a nonlinear system using first order RBF network
%
% Usage: [w,V,e] = f_rbfw (f,N,a,b,m,n,d,mu,ic,w,V)
%
% Inputs: 
%         f  = string containing name of user-supplied function
%              which specifies the right-hand side of the 
%              nonlinear discrete-time system.
%
%              y(k)     = f(theta(k),m,n)
%              theta(k) = [x(k),...,x(k-m),y(k-1),...,y(k-n)]'
%
%         N    = number of training samples (N >= 0). If N=0,
%                the weights returned are the initial weights 
%                computed according to input ic.
%         a    = 2 by 1 vector of input bounds
%         b    = 2 by 1 vector of output bounds
%         m    = number of past inputs (m >= 0)
%         n    = number of past outputs (n >= 0)
%         d    = number of grid points per dimension
%         mu   = step length for gradient search
%         ic   = an initial condition code. If ic <> 0,
%                initial values for w and V are computed
%                such that the error is zero at the grid
%                points.
%         w    = an optional r by 1 vector containing the
%                initial values of the weight vector
%                (default: w = 0)
%         V    = an optional r by p matrix containing the
%                initial values of the weight matrix.
%                (default V = 0).
% Outputs: 
%          w = r by 1 weight vector
%          V = r by p weight matrix 
%          e = an optional N by 1 vector of errors where 
%              e(k) = y(k)-y_0(k)
% Notes: 
%        1. r = d^p where p = m+n+1
%        2. Good value for the initial weights are w(i) = 
%           f(theta(i)) and V(i,:) = df(theta(i))/dtheta.
%   
% See also: F_RBFW

% Initialize

m = f_clip (m,0,m);
n = f_clip (n,0,n);
d = f_clip (d,2,d);
N = f_clip (N,0,N);
p = m + n + 1;
r = d^p;
theta = zeros(p,1);
if ic
    w = zeros(p,1);
    V = zeros(r,p);
    for i = 0 : r-1
        theta = f_gridpoint (i,a,b,m,n,d);
        V(i+1,:) = zeros(1,p);            % fix this some time
        w(i+1) = feval(f,theta,m,n);
    end
    if N < 1
        e = zeros(N,1);
        return
    end
end
if (nargin < 10) & (ic == 0)
   w = zeros(r,1);
end
if (nargin < 11) & (ic == 0)
   V = zeros(r,p);
end
e = zeros(N,1);
y = zeros(N,1); 
M = 2^p;
z = zeros(M,1);
Vert = zeros(p,M);
x = f_randu (N,1,a(1),a(2));

% Find optimal weight vector

caption = '';
h = waitbar (0,caption);
for k = 1 : N
    waitbar (k/N,h,caption);
    theta = f_state(x,y,k,m,n);
    y(k) = feval(f,theta);
    [index,Vert] = f_neighbors (theta,a,b,m,n,d);
    y_0 = 0;
    for j = 1 : M
        z(j) = f_rbfg (theta-Vert(:,j),a,b,m,n,d);
        y_0 = y_0 + w(index(j)+1)*z(j);
    end
    e(k) = y(k) - y_0;
    for j = 1 : M
        s = index(j)+1;
        w(s) = w(s) + 2*mu*e(k)*z(j);
        V(s,:) = V(s,:) + 2*mu*e(k)*z(j)*(theta-Vert(:,j))';
    end
    if mod(k,N/100)
        caption = sprintf ('e^2 = %10.6f',e(k)^2);
    end
end
close (h)
