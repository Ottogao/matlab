function f_circle (x,y,dia,color)

%F_CIRCLE: Draw a circle in current plot
%
% Usage: f_circle (x,y,dia,color)
%
% Inputs: 
%         x     = x coordinate of circle
%         y     = y coordinate of circle
%         dia   = diameter of circle 
%         color = optional 1 by 3 color array
%
% Notes: Used by chapter GUI modules

% Draw circle

n = 100;
r = dia/2;
phi = linspace(0,2*pi,n);
x0 = x + r*cos(phi);
y0 = y + r*sin(phi);
if (nargin < 4)
   plot (x0,y0,'k')
else
   plot (x0,y0,'Color',color)
end

