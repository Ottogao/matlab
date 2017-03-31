function y = f_deadzone (x,a,b)

%F_DEADZONE: Insert a dead zone interval
%
% Usage: y = f_deadzone (x,a,b)
%
% Inputs: 
%         x  = input to be processed
%         a  = lower limit of dead zone range
%         b  = upper limit of dead zone range
% Outputs: 
%          y = output defined as follows.  y = x if x < a
%              or x > b.  Otherwise y = 0;
%
% See also: F_CLIP, F_PROMPT, F_WAIT

y = x;
n = length(x);
for i = 1 : n
   if (x(i) >= a) & (x(i) <= b)
      y(i) = 0;
   end
end
