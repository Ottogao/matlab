function y = f_dac (b,N,Vr)

%F_DAC: Perform N-bit digital to analog conversion
%
% Usage: y = f_dac (b,N,Vr)
%
% Inputs: 
%         b  = string containing N-bit binary input
%         N  = number of bits
%         Vr = reference voltage (-Vr <= y < Vr)
% Outputs: 
%          y = analog output
%
% See also: F_ADC

q = 2*Vr/2^N;
x = -(2^(N-1));
for i = 1 : N
   x = x + b(i)*2^(i-1);
end
y = x*q;
