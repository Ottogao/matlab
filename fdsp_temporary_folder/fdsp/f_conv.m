function y = f_conv (h,x,circ)

%F_CONV: Fast linear or circular convolution
%
% Usage: y = f_conv (h,x,circ)
%
% Inputs: 
%         h    = vector of length L containing pulse 
%                response signal
%         x    = vector of length M containing input signal
%         circ = convolution type code:
%
%                0 = linear convolution
%                1 = circular convolution (requires M = L)
% Outputs: 
%          y = vector of length L+M-1 containing the 
%              convolution of h with x 
%
% Note: If h is the impulse response of a discrete-time 
%       linear system and x is the input, then y is the 
%       zero-state response when circ = 0.
%         
% See also: F_BLOCKCONV, F_CORR, CONV, DECONV

% Initialize

L = length(h);
M = length(x);
if circ
   N = min(L,M);
else
   N = 2^ceil(log(L+M-1)/log(2));
end

% Compute convolution

H = fft(f_tocol(h),N);
X = fft(f_tocol(x),N);
r = ifft(H .* X);
if circ
   y = real(r);
else
   y(1:L+M-1) = real(r(1:L+M-1));
end
