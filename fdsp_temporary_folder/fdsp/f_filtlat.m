function y = f_filtlat (K,b_0,x)

%F_FILTLAT: Compute output of lattice form filter realization
%
% Usage: y = f_filtlas (K,b_0,x)
%
% Inputs: 
%         K   = 1 by m vector containing reflection 
%               coefficients
%         b_0 = numerator gain factor
%         x   = vector of length p containing samples of
%               input signal. 
% Outputs: 
%          y = vector of length p containing samples of 
%              output signal assuming zero initial 
%              conditions.
%
% Note: The arguments K and b_0 are obtained by calling 
%       f_lattice
%
% See also: F_LATTICE, F_CASCADE, F_PARALLEL, F_FILTCAS, 
%           F_FILTPAR, FILTER

% Initialize

p = length(x);
m = length(K);
u = zeros(m+1,p);
v = zeros(m+1,p);
y = zeros(size(x));

% Compute output

for k = 1 : p
   u(1,k) = x(k);
   v(1,k) = x(k);
   for i = 1 : m
      if k == 1
         u(i+1,k) = u(i,k);
         v(i+1,k) = K(i)*u(i,k);
      else
         u(i+1,k) = u(i,k) + K(i)*v(i,k-1);
         v(i+1,k) = K(i)*u(i,k) + v(i,k-1);
      end
   end
   y(k) = b_0*u(m+1,k);
end
