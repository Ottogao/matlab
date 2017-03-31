function [y,L,c] = f_string (x,F_0,fs,r)

%F_STRING: Compute output of tunable plucked-string filter
%
% Usage: [y,L,c] = f_string (x,F_0,fs,r);
%
% Inputs: 
%         x   = 1 by n vector of input samples
%         F_0 = first resonant frequency (20 to fs/4)
%         fs  = sampling frequency
%         r   = attenuation factor
% Outputs: 
%          y = 1 by n vector of output samples
%          L = feedback delay
%          c = pitch parameter
%
% See also: F_REVERB

% Compute parameters

F_0 = f_clip(F_0,20,fs/4);
L = floor((fs-0.5*F_0)/F_0);
delta = (fs - (L+0.5)*F_0)/F_0;
c = (1-delta)/(1+delta);

% Compute coefficients and output

a = zeros(1,L+3);
b = 0.5*[c, (1+c), 1];
a(1:2) = [1,c];
a(L+1:L+3) = -r^L*b;
y = filter (b,a,x);
