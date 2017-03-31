function [b,d,y] = f_adc (x,N,Vr)

%F_ADC: Perform N-bit analog-to-digital conversion
%
% Usage: [b,d,y] = f_adc (x,N,Vr);
%
% Inputs: 
%         x  = analog input
%         N  = number of bits
%         Vr = reference voltage (-Vr <= x < Vr)
% Outputs: 
%          b = 1 by N array containing binary output
%          d = decimal output (offset binary)
%          y = quantized analog output
%
% See also: F_DAC

% Initialize

q = 2*Vr/2^N;
b = zeros(1,N);
m = 2^(N-1);

% Perform conversion

for i = N : -1 : 1
   b(i) = 1;
   z = f_dac(b,N,Vr);
   if z > x
      b(i) = 0;
   end
end

% Decimal and quantized outputs

d = -m + floor((x+q/2+Vr)/q);
d = max(min(d,m-1),-m);
y = Vr*d/m;
 