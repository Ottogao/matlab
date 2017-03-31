function y = f_clip (x,a,b,k,s)

% F_CLIP: Clip a value, or a calling argument, to an interval
%
% Usage: y = f_clip (x,a,b,k,s)
%
% Inputs: 
%         x = input to be clipped
%         a = lower limit of clip range
%         b = upper limit of clip range
%         k = an optional integer specifying the number of
%             the calling argument
%         s = an optional string specifying the name of the
%             function being called.
% Outputs: 
%          y = x clipped to interval [a,b].  If a <= x <= b,
%              then y = x.
%
% See also: F_DEADZONE, F_WAIT, F_PROMPT

y = min(x,b);
y = max(y,a);
if (nargin >= 5) & (y ~= x)
    fprintf ('\nCalling argument %d of %s was clipped to [%g,%g].\n',k,s,a,b);
end
