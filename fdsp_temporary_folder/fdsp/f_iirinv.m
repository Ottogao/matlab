function [b,a] = f_iirinv (n,Delta_F,fs)

%F_IIRINV: Design an IIR inverse comb filter
%
% Usage: [b,a] = f_iirinv (n,Delta_F,fs)
%
% Inputs: 
%         n       = filter order 
%         Delta_F = 3dB radius of notches
%         fs      = sampling frequency 
% Outputs: 
%          b = 1 by (n+1) numerator coefficient vector 
%          a = 1 by (n+1) denominator coefficient vector 
%
% See also: F_IIRCOMB, F_IIRRES, F_IIRNOTCH

% Initialize

n = floor(f_clip(n,2,n));
fs = f_clip (fs,0,fs);
Delta_F = min(f_clip(Delta_F,0,Delta_F),fs/(2*n));
 
% Find the parameters

r = 1 - (Delta_F*pi)/fs;
b_0 = (1 + r^n)/2;

% Find the coefficient vectors

b = b_0*[1,zeros(1,n-1),-1];
a = [1,zeros(1,n-1),-r^n];
   