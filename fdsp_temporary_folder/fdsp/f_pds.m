function [S,f,Px] = f_pds (x,N,L,fs,win,meth)

%F_PDS: Compute estimated power density spectrum
%
% Usage: [S,f,Px] = f_pds (x,N,L,fs,win,meth);
%
% Inputs: 
%         x    = vector of length n containing input samples
%         N    = total number of samples.  If N > n, then
%                x is padded with N - n zeros.
%         L    = length of subsequence to use.  L must be an
%                integer factor of N.  That is N = LM for a
%                pair of integers L and M. 
%         fs   = sampling frequency
%         win  = window type to be used 
%
%                0 = rectangular
%                1 = Hanning
%                2 = Hamming
%                3 = Blackman
%
%         meth = an integer method selector.  
%
%                0 = Bartlett's average periodogram
%                1 = Welch's modified average periodogram
% Outputs: 
%          S  = 1 by L vector containing estimate of power 
%               density spectrum
%          f  = 1 by L vector containing frequencies at 
%               which S is evaluated (0 to (L-1)fs/L).
%          Px = average power of x
%
% See also: F_SPEC

% Initialize

f = linspace (0,(L-1)*fs/L,L);
S = zeros(1,L);
Px = 0;
M = N/L;
if M > floor(N/L)
   fprintf ('\nArgument 3 of f_pds must be an integer submultiple of argument 2.\n')
   return
end
s = size(x);
if s(1) < s(2)
    y = x;
else
    y = x';
end
n = length(x);
if N > n
   y = [y zeros(1,N-n)];
end
x_m = zeros(1,L);
A_m = zeros(1,L);
w = f_window (f_clip(win,0,3),L-1);         % This was L!

% Use Bartlett's method (with window w)

if meth == 0
    
   if L == N
       S = abs(fft(y .* w)).^2/L;
   else
      h = waitbar (0,'Computing Periodograms');
      for i = 1 : L
         for m = 0 : M-1
            x_m = y(m*L+1:m*L + L);
            x_m = w .* x_m;
            A_m = abs(fft(x_m));
            S(i) = S(i) + A_m(i)^2;
         end
         waitbar (i/L,h);
      end
      close(h);
      S = S/(M*L);
  end
  
else
  
% Use Welch's method

   if L == N
       S = abs(fft(y .* w)).^2/L;
   else
      h = waitbar (0,'Computing Periodograms');
      for i = 1 : L
         for m = 0 : 2*M-2
            x_m = y(m*L/2+1:m*L/2 + L);
            x_m = w .* x_m;
            A_m = abs(fft(x_m));
            S(i) = S(i) + A_m(i)^2;
        end
        waitbar (i/L,h);
      end
      close(h);
      U = (1/L)*sum(w.^2);
      S = S/((2*M-1)*L*U);
  end
  
end

% Compute average power

for i = 1 : n
    Px = Px + x(i)^2;
end
Px = Px/n;
