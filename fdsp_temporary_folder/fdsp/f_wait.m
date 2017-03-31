function  f_wait (s)

% F_WAIT: Pause and wait for a key to be pressed
%
% Usage: f_wait (s)
%
% Inputs: 
%         s = an optional prompt string.  The default is
%            'Press any key to continue ...'
%
% See also: F_PROMPT, F_CLIP

if nargin < 1
    w = '\nPress any key to continue ...\n';
else
    w = ['\n' s '\n'];
end
fprintf (w)
pause 
