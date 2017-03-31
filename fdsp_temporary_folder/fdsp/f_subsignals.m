function X = f_subsignals (p)
% F_SUBSIGNALS: Compute a matrix of bandlimited subsignals
%
% Usage: X = f_subsignals (p);
%
% Inputs: 
%         p = subsignal length
% Outputs: 
%          X = p by 4 matrix containing the samples of four
%              subsignals in each column. Each subsignal is
%              bandlimited to fs/4.

fs = 1;
A = zeros(p,1);
F_0 = fs/4;
f = linspace (-fs/2,(p-1)*fs/(2*p),p)';

% Construct signals in frequency domain

for k = 1 : 4
   for i = 1 : p
       switch (k)
          case 1,                                  % cosine
              if abs(f(i)) <= F_0
                  A(i) = cos(pi*f(i)/(2*F_0));
              end
          case 2,                                  % triangle 
              if abs(f(i)) <= F_0
                  A(i) = 1 - abs(f(i))/F_0;
              end
          case 3,                                  % |sin|
              if abs(f(i)) <= F_0
                  A(i) = abs(sin(pi*f(i)/F_0));               
              end
          case 4,                                  % sqrt
              if abs(f(i)) <= F_0
                  A(i) = 1 - sqrt(abs(f(i))/F_0);
              end
       end
   end
   
% Restore to regular FFT order and invert   
   
   B = fftshift (A);
   X(:,k) = ifft (B);
   
end
 