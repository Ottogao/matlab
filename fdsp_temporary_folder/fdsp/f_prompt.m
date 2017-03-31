function x = f_prompt (s,a,b,df)

%F_PROMPT: Prompt user for numerical input in specified range
%
% Usage: 
%        x = f_prompt (s,a,b,df)
%
% Inputs: 
%         s  = prompt string
%         a  = lower limit for response
%         b  = upper limit for response (b >= a)
%         df = default response (a <= df <= b)
% Outputs: 
%          x = value entered by user  
%
% See also: F_WAIT, F_CLIP

q = sprintf ('%s (%g to %g, default: %g): ',s,a,b,df);
x = a - 1;
while ((x < a) | (x > b))
   x = input (q);
   if isempty(x)
      x = df;   
   end
end   
