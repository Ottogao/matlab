function f_line (x,y,dx,dy,len,color)

%F_LINE: Draw a line segment on current figure
%
% Usage: f_line (x,y,dx,dy,len,color)
%
% Inputs: 
%         x     = x coordinate of start of line
%         y     = y coordinate of start of line
%         dx    = denominator of line slope 
%         dy    = numerator of line slope
%         len   = length of line measured along xaxis
%                 if dx ~= 0 or y axis otherwise
%         color = optional 1 by 3 color array for line color
%
% Note: Used by GUI modules

% Draw line

hold on
if dx ~= -0
   x1 = x + sign(dx)*len;
   y1 = y + (dy/dx)*len;
else
   y1 = y + sign(dy)*len;
   x1 = x;
end
if (nargin <= 5)
   plot([x x1],[y y1],'k')
else
   plot([x x1],[y y1]','Color',color)
end
