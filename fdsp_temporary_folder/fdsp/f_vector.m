function f_vector (x,y,dx,dy,len,color)

%F_VECTOR: Draw a vector on current plot
%
% Usage: f_vector (x,y,dx,dy,len,color)
%
% Inputs: 
%         x     = x coordinate of start of vector
%         y     = y coordinate of start of vector
%         dx    = denominator of vector slope 
%         dy    = numerator of vector slope
%         len   = length of vector measured along xaxis
%                 if dx ~= 0 or y axis otherwise
%         color = optional 1 by 3 color vector 
%
% Note: Used by GUI modules

% Draw line

hold on
alen = 0.02;
len1 = len - alen;
if dx ~= -0
   x1 = x + sign(dx)*len1;
   y1 = y + (dy/dx)*len1;
   x2 = x + sign(dx)*len;
   y2 = y + (dy/dx)*len;
else
   x1 = x;
   y1 = y + sign(dy)*len1;
   x2 = x;
   y2 = y + sign(dy)*len;
end
if (nargin < 6)
   plot([x x1],[y y1],'k')
else
   plot([x x1],[y y1],'Color',color)
end

% Add arrowhead

if dy == 0
   x0 = [x2 x1 x1 x2];
   y0 = [y2 y2+alen/2 y2-alen/2 y2];
else
   x0 = [x2 x2+alen/2 x2-alen/2 x2];
   y0 = [y2 y1 y1 y2];
end
if (nargin < 6)
   plot (x0,y0,'k')
else
   plot (x0,y0,'Color',color)
end
