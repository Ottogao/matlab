function w = f_window (i,n)

%F_WINDOW: Compute data window vector
%
% Usage: w = f_window (i,n)
%
% Inputs: 
%         i  = window number defined as follows:
%
%              0 = rectangular
%              1 = Hanning
%              2 = Hamming
%              3 = Blackman
%
%         n  = the window order
% Outputs: 
%          w = 1 by n+1 vector contain values of window
%
% See also: F_PDS, F_FIRWIN, F_FIRIDEAL

p = n/2;
k = 0 : n;
w = ones(1,n+1);                                      % rectangular
switch (i)
case 1,                                 
   w = 0.5 - 0.5*cos(pi*k/p);                         % Hanning
case 2, 
   w = 0.54 - 0.46*cos(pi*k/p);                       % Hamming
case 3, 
   w = 0.42 - 0.5*cos(pi*k/p) + 0.08*cos(2*pi*k/p);   % Blackman
end
 