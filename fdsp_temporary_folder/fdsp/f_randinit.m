function f_randinit (s)

%F_RANDINIT: Initialize random number generator
%
% Usage: f_randinit (s)
%
% Inputs: 
%         s = an integer seed which selects a random
%             sequence.  If seed <= 0, a random seed
%             based on the time of day is selected.
%
% See also: F_RANDU, F_RANDG

if s > 0
   rand ('state',s)
else
   rand ('state',sum(100*clock))
end
