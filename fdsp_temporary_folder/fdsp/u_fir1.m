function A = u_fir1 (f,fs)

%U_FIR1: Example user file for GUI module G_FIR
%
% Usage: A = u_fir1 (f,fs);
%
% Inputs: 
%         f  = vector of input frequencies in the range [0,fs/2]
%         fs = sampling frequency
% Outputs: 
%          A = desired magnitude response vector evalutated at f 

n = length(f);
for i = 1 : n
   if f(i) < fs/4
      A(i) = 4*f(i)/fs;
   else
      A(i) = 0;
   end
end
