function f_block (x,y,wide,high,color)

%F_BLOCK: Draw a block using the current axes
%
% Usage: f_block (x,y,wide,high,color)
%
% Inputs: 
%         x     = x coordinate of lower left corner
%         y     = y coordinate of lower left corner
%         wide  = width of block
%         high  = height of block
%         color = optional 1 by 3 color vector
%
% Note: Used by chapter GUI modules

% Draw block

x0 = [x x+wide x+wide x x];
y0 = [y y y+high y+high y];
if (nargin < 5)
   plot (x0,y0,'k')
else
   plot (x0,y0,'Color',color)
end

