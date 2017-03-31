function [B,A,R_0] = f_parallel (b,a)

%F_PARALLEL: Find parallel form filter realization
%
%            H(z) = R_0 + H_1(z) + ... + H_N(z)
%
% Usage: [B,A,R_0] = f_parallel (b,a)
%
% Inputs: 
%         b = vector of length n+1 containing coefficients 
%             of numerator polynomial.
%         a = vector of length n+1 containing coefficients 
%             of denominator polynomial.
% Outputs: 
%          B   = N by 3 matrix containing coefficients of 
%                numerators of second-order blocks.
%          A   = N by 3 matrix containing coefficients of 
%                denominators of second-order blocks.
%          R_0 = constant term of parallel form realization.
% Notes: 
%        1. It is required that length(b) = length(a) with 
%           b(1)~= 0. If needed, pad b with trailing zeros.
%
%        2. To evaluate parallel form realization use 
%           f_filtpar.
%
% See also: F_FILTPAR, F_CASCADE, F_LATTICE, FILTER

% Initialize

n = length(a) - 1;
m = length(b) - 1;
N = floor((n+1)/2);
if  (m > n) | (abs(polyval(a,0)) < eps)
   fprintf ('\nFunction f_parallel requires that H(z) not have any poles at z = 0.\n')
   R_0 = 0;
   B = 0;
   A = 1;
   f_wait
   return
end
tol = sqrt(eps);

% Add pole at z = 0

if (m < n)
    b = [f_torow(b),zeros(n-m)];
    m = n;
end

% Sort poles and residues

[R,P,K] = residue (b,a);
R = R ./ P;
R_0 = K - sum(R);
r = zeros(size(R));
p = zeros(size(P));
i = 1;
c = 0;
d = n;
while (i <= n)
   if (i < n) & (abs(imag(P(i) + P(i+1))) < tol)
      p(c+1) = P(i);
      p(c+2) = P(i+1);
      r(c+1) = R(i);
      r(c+2) = R(i+1);
      c = c + 2;
      i = i + 2;
   else
      p(d) = P(i);
      r(d) = R(i);
      d = d - 1;
      i = i + 1;
   end
end

% Compute second-order blocks

k = 1;
for i = 1 : N
   if (mod(n,2) == 0) | (i < N)
      B(i,1:3) = [r(k)+r(k+1), -(r(k)*p(k+1)+r(k+1)*p(k)), 0];
      A(i,1:3) = [1, -(p(k)+p(k+1)), p(k)*p(k+1)];
      k = k + 2;
   else
      B(N,1:3) = [r(k), 0, 0];
      A(N,1:3) = [1, -p(k), 0];
      k = k + 1;
   end
end
  