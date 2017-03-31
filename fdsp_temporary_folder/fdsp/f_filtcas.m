function y = f_filtcas (B,A,b_0,x)

%F_FILTCAS: Compute output of cascade form filter realization
%
% Usage: y = f_filtcas (B,A,b_0,x)
%
% Inputs: 
%         B   = N by 2 matrix containing numerator 
%               coefficients of second-order blocks. 
%         A   = N by 3 matrix containing denominator 
%               coefficients of second-order blocks.
%         b_0 = numerator gain factor
%         x   = vector of length p containing samples of
%               input signal. 
% Outputs: 
%          y = vector of length p containing samples of 
%              output signal assuming zero initial 
%              conditions.
%
% Note: The arguments B, A, and b_0 are obtained by calling
%       f_cascade.
%
% See also: F_CASCADE, F_PARALLEL, F_LATTICE, F_FILTPAR, 
%           F_FILTCAS, FILTER

% Initialize

N = size(B,1);
y = b_0*x;

% Compute output

for i = 1 : N
   w = y;
   y = filter (B(i,:),A(i,:),w);
end
  