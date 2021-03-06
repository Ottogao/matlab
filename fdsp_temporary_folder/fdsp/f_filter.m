function y = f_filter (b,a,x,bits,realize)

%F_FILTER: Compute the zero-state response of the following filter
%
%                     b(1) + b(2)z^(-1) + ...+ b(M+1)z^(-m)
%              H(z) = --------------------------------------
%                     a(1) + a(2)z^(-1) + ... + a(N+1)z^(-n)  
%
% Usage: y =f_filter (b,a,x,bits,realize);
%
% Inputs: 
%         b        = coefficient vector of numerator polynomial 
%         a        = coefficient vector of denominator polynomial
%         x        = a vector of length N containing the input
%         bits     = optional integer specifyiing the number of
%                    fixed-point bits used for coefficient quantization.
%                    The default is double precision floating-point   
%         realize  = optional integer specifying the realization
%                    structure to use.  The default is to use the 
%                    firect form of MATLAB function filter.   
%
%                    0 = direct form
%                    1 = cascade form
%                    2 = lattice form (FIR) or parallel form (IIR)
% Outputs: 
%          y = N by 1 vector containing zero-state respones of H(z) to
%              the input x.
%
% Notes: For the parallel form, the poles of H(z) must be distinct.
%
% See also: filter

% Initialize

if (nargin >= 4) & (~isempty(bits)) 
    c = max(abs([a(:) ; b(:)]));
    c = 2^(ceil(log(c)/log(2)));
    q = c/2^(bits-1);
    b_q = f_quant(b,q,0);
    a_q = f_quant(a,q,0);
    a_q(1) = 1;
else
    b_q = b;
    a_q = a;
    bits = 64;
end
    
N = length(x);
y = zeros(N,1);
r = max(abs(roots(a)));
r_q = max(abs(roots(a_q)));
if r >= 1
   fprintf ('\nThe filter in f_filter is not stable.\n')
end
if r_q >= 1
   fprintf ('\nThe quantized filter in f_filter is not stable.\n')
end

% Compute zero-state response

if nargin < 5
   y = filter(b_q,a_q,x);
else
   iir_test = sum(a(2:length(a)).^2); 
   if iir_test > 0                % IIR
       switch realize
           case 0, 
               y = filter (b_q,a_q,x);
           case 1,
               [B,A,b_0] = f_cascade (b,a);
               c1 = max(abs([B(:) ; A(:) ; b_0]));
               c1 = 2^(ceil(log(c1)/log(2)));
               q1 = c1/2^(bits-1);
               B_q = f_quant (B,q1,0);
               A_q = f_quant (A,q1,0);
               b_0q = f_quant (b_0,q1,0);
               y = f_filtcas (B_q,A_q,b_0,x);            % b_0 not quantized
           case 2,
               [B,A,R_0] = f_parallel (b,a);
               c1 = max(abs([B(:) ; A(:) ; R_0]));
               c1 = 2^(ceil(log(c1)/log(2)));
               q1 = c1/2^(bits-1);
               B_q = f_quant (B,q1,0);
               A_q = f_quant (A,q1,0);
               R_0q = f_quant (R_0,q1,0);
               y = f_filtpar (B_q,A_q,R_0,x);           % R_0 not quantized
       end
   else                           % FIR 
       switch realize
           case 0, 
               y = filter (b_q,a_q,x);
           case 1,
               [B,A,b_0] = f_cascade (b);
               c1 = max(abs([B(:) ; A(:) ; b_0]));
               c1 = 2^(ceil(log(c1)/log(2)));
               q1 = c1/2^(bits-1);
               B_q = f_quant (B,q1,0);
               A_q = A;
               b_0q = f_quant (b_0,q1,0);
               y = f_filtcas (B_q,A_q,b_0,x);         % b_0 not quantized
           case 2,
               [K,b_0] = f_lattice (b);
               c1 = max(abs([K(:) ; b_0]));
               c1 = 2^(ceil(log(c1)/log(2)));
               q1 = c1/2^(bits-1);
               K_q = f_quant (K,q1,0);
               b_0q = f_quant (b_0,q1,0);
               y = f_filtlat (K_q,b_0,x);              % b_0 not quantized
       end
   end
end


    