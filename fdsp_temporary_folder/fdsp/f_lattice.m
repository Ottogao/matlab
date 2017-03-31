function [K,b_0] = f_lattice (b)

%F_LATTICE: Find lattice form FIR filter realization 
%
% Usage: [K,b_0] = f_lattice (b)
%
% Inputs: 
%         b = vector of length m+1 containing coefficients
%             of numerator polynomial.
% Outputs: 
%          K   = 1 by m vector containing reflection 
%                coefficients
%          b_0 = numerator gain
%
% Notes: This algorithm assumes that $|K(i)| ~= 1$ 
%        for 1 <= i <= m.
%
% See also: F_FILTLAT, F_CASCADE, F_PARALLEL

% Initialize

m = length(b) - 1;
b_0 = b(1);
A = b/b_0;
K = zeros(1,m);
B = zeros(size(A));
B(1:m+1) = A(m+1:-1:1);
K(m) = A(m+1);

% Compute reflection coefficients

for i = m : -1 : 2
   if (abs(abs(K(i))-1) < 1.e-10)
      fprintf ('Function f_lattice found a zero on the unit circle.\n')
      return;
   end
   A = (A - K(i)*B) /(1 - K(i)^2);
   B(1:i) = A(i:-1:1);
   B(i+1:m+1) = 0;
   K(i-1) = A(i);
end
