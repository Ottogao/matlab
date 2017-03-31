function f_labels (caption,xaxis,yaxis,zaxis,fsize)

%F_LABELS: Add title and axis labels to current plot 
%
% Usage: f_labels (caption,xaxis,yaxis,zaxis,fsize)
%
% Inputs: 
%         caption = figure title
%         xaxis   = x axis label
%         yaxis   = y axis label
%         zaxis   = optional z axis label
%         fsize   = optional font size         
%
% See also: F_WAIT

if nargin < 5
    fsize = 10;
end
title (caption,'FontName','FixedWidthFontName','FontSize',fsize)
xlabel (xaxis,'FontName','FixedWidthFontName','FontSize',fsize)
ylabel (yaxis,'FontName','FixedWidthFontName','FontSize',fsize)
if (nargin > 3)
   zlabel (zaxis,'FontName','FixedWidthFontName','FontSize',fsize)
end
