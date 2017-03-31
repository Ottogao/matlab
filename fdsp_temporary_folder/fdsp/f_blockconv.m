function y = f_blockconv (h,x)

% F_BLOCKCONV: Fast linear block convolution of two signals
%
% Usage: y = f_blockconv (h,x)
%
% Inputs: 
%         h = vector of length L containing first signal 
%         x = vector of length M > L containing second signal
% Outputs: 
%          y = vector of length L+M-1 containing the 
%              convolution of h with x
%
% See also: F_CONV, F_CORR

% Initialize

L = length(h);
M = length(x);
if M < L
    y = f_blockconv (x,h);
    return
elseif M == L
    y = f_conv(h,x,0);
    return
end

% Pad x with zeros, as needed, to make M = QL for some integer Q

M_save = M;
r = L - mod(M,L);
M = M + r;
x_z = [f_torow(x) zeros(1,r)];
Q = M/L;
y = zeros(1,L+M_save-1);

% Compute h_z and H_z

N = 2^(ceil(log(2*L-1)/log(2)));
h_z = [f_torow(h) zeros(1,N-L)];
H_z = fft(h_z);

% Compute y

y0 = zeros(1,L*(Q-1)+N);
y1 = zeros(1,N);
for i = 0 : Q-1
    m = i*L;
    x_i = x_z(m+1:m+L);
    x_iz = [f_torow(x_i) zeros(1,N-L)];
    X_iz = fft(x_iz);
    y1 = ifft(H_z .* X_iz);
    y0(m+1:m+N) = y0(m+1:m+N) + y1;
end
y = real(y0(1:L+M_save-1));
