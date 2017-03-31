function [y,n] = f_reverb (x,fs)

%F_REVERB: Compute output of reverberation filter
%
% Usage: [y,n] = f_reverb (x,fs);
%
% Inputs: 
%         x  = vector of n input samples
%         fs = sampling frequency
% Outputs: 
%          y = vector of n output samples
%          n = filter order (proportional to fs)
%
% Note: The recommended sampling frequency is fs = 22050 Hz.
%
% See also: F_STRING

% Initialize (Moorer, 1979)

p = 6;
L = floor([50 56 61 68 72 78]*fs/1000);          
g = [0.24 0.26 0.28 0.29 0.30 0.32];
r = 0.83; 
Lmax = max(L);

% Compute output from comb filters

n = length(x);
v = zeros(size(x));
a = zeros(p,Lmax+2);
b = zeros(p,Lmax+2);
h = waitbar(0,'Computing reverb output');
for i = 1 : p
   waitbar ((i-1)/(p-1),h)
   a(i,1) = 1;
   b(i,L(i)+1) = r;
   a(i,2) = -g(i);
   a(i,L(i)+1) = -r*(1-g(i));
   b(i,L(i)+2) = -r*g(i);
   v = v + filter(b(i,1:L(i)+2),a(i,1:L(i)+2),x);
end
close (h)

% Send it through the allpass filter

c = 0.7;
M = floor(0.006*fs);
a1 = [1 zeros(1,M) c];
b1 = [c zeros(1,M) 1];
y = filter (b1,a1,v);
n = M + p + sum(L);
