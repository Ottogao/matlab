function y = f_quant (x,q,qtype)

%F_QUANT: Quantization operator
%
% Usage: y = f_quant (x,q,qtype)
%
% Inputs: 
%         x     = real value to be quantized
%         q     = quantization level
%         qtype = quantization type:
%
%                 0 = rounding
%                 1 = truncation
% Outputs: 
%          y = quantized version of x
%
% See also: F_DAC, F_ADC

if qtype == 0
   y = q*floor((x+q/2)/q);     % rounding
else  
   y = q*floor(x/q);           % truncation
end
