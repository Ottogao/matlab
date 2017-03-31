function y = f_filtpar (B,A,R_0,x)

%F_FILTPAR: Compute output of parallel form filter realization
%
% Usage: y = f_filtpar (B,A,R_0,x)
%
% Inputs: 
%         B   = N by 2 matrix containing numerator 
%               coefficients of second-order blocks. 
%         A   = N by 3 matrix containing denominator 
%               coefficients of second-order blocks.
%         R_0 = direct term of parallel form realization
%         x   = vector of length p containing samples
%               of input signal. 
% Outputs: 
%          y = vector of length p containing samples of
%              output signal assuming zero initial 
%              conditions.
%
% Note: The arguments B, A, and H_0 are obtained by 
%       calling f_parallel.
%
% See also: F_PARRALLEL, F_CASCADE, F_LATTIC, F_FILTCAS, 
%           F_FILTLAT, FILTER

% Initialize


N = size(B,1);
y = R_0*x;

% Compute output

for i = 1 : N
   y = y + filter (B(i,:),A(i,:),x);
end
