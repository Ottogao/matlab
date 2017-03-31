function r = f_corr (x,y,circ,norm)

% F_CORR: Fast cross-correlation of two discrete-time signals
%
% Usage: r = f_corr (x,y,circ,norm)
%
% Inputs: 
%         x    = vector of length L containing first signal
%         y    = vector of length M <= L containing second 
%                signal
%         circ = correlation type code:
%
%                0 = linear correlation
%                1 = circular correlation
%
%         norm = normalization code:
%
%                0 = no normalization 
%                1 = normalized cross-correlation
% Outputs: 
%          r = vector of length L contained selected cross- 
%              correlation of x with y.
%
% Notes: To compute auto-correlation use y = x.
%
% See also: F_CONV, F_BLOCKCONV, CONV

% Initialize

L = length(x);
M = length(y);

if M > L
   fprintf ('\nThe length of argument 2 of fcorr exceeds the length')
   fprintf ('\nof argument 1.\n')
   return;
end

if circ

% Compute circular cross-correlation

   if M ~= L
      fprintf ('\nThe length of argument 2 of fcorr must equal the length')
      fprintf ('\nof argument 1 for a circular cross-correlation.\n')
      return;
   else
      X = fft(f_tocol(x),L);
      Y = fft(f_tocol(y),L);
      s = ifft(X .* conj(Y))/L;
      r = real(s);
   end

else
    
% Compute linear cross-correlation

   N = 2^ceil(log(L+M-1)/log(2));
   X = fft(f_tocol(x),N);
   Y = fft(f_tocol(y),N);
   s = ifft(X .* conj(Y))/L;
   r = real(s(1:L));

end

% Normalize 

if norm 
   P_x = sum(x .^ 2)/L;
   P_y = sum(y .^ 2)/M;
   r = r/sqrt((M/L)*P_x*P_y);
end
