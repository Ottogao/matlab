function A = f_firamp (f,fs,p);

%F_FIRAMP: Amplitude response of frequency-selective filter
%
% Usage: A = f_firamp (f,fs,p);
%
% Inputs: 
%         f  = vector of length N contain input frequencies
%         fs = sampling frequency
%         p  = vector containing filter parameters
%
%              p(1) = filter type
%
%                     0 = lowpass
%                     1 = highpass
%                     2 = bandpass
%                     3 = bandstop
%
%              p(2) = first cutoff frequency, F_0
%              p(3) = second cutoff frequency, F_1
%              p(4) = transition bandwidth, B
% Outputs: 
%          A  = vector containing amplitude response 
%               evaluated at vector f.
%
% Note: This can be used as the first calling argument
%       of f_firwin     
%
% See also: F_FIRWIN, F_FIRIDEAL

% Initialize

A = zeros(size(f));
f_type = p(1);
F_0 = p(2);
F_1 = p(3);
B = p(4);

% Compute amplitude

switch (f_type)
   
case 0,
   
   i1 = find(f <= F_0);
   A(i1) = 1;
   i2 = find((f > F_0) & (f < F_0+B));
   A(i2) = 1 - (f(i2)-F_0)/B; 
   
case 1,
   
   i1 = find(f >= F_1);
   A(i1) = 1;
   i2 = find((f > F_1-B) & (f < F_1));
   A(i2) = (f(i2) - (F_1-B))/B;
   
case 2,
   
   i1 = find((f >= F_0) & (f <= F_1));
   A(i1) = 1;
   i2 = find((f > F_0-B) & (f < F_0));
   A(i2) = (f(i2) - (F_0-B))/B;
   i3 = find((f > F_1) & (f < F_1+B));
   A(i3) = 1 - (f(i3)-F_1)/B;
   
case 3,
   
   i1 = find((f <= F_0-B) | (f >= F_1+B));
   A(i1) = 1;
   i2 = find((f > F_0-B) & (f < F_0));
   A(i2) = 1 - (f(i2) - (F_0-B))/B;
   i3 = find((f > F_1) & (f < F_1+B));
   A(i3) = (f(i3)-F_1)/B;
   
end
