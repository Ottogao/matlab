function [h_edit,dw,dh] = f_editbox (v,vmin,vmax,pos,nbox,row,col,fcolor,bcolor,cback,tipstr,fsize)

%F_EDITBOX: Create edit box
%
% Usage: h = f_editbox (v,vmin,vmax,pos,nbox,row,col,fcolor,bcolor,cback,tipstr,fsize)
%
% Inputs: 
%          v      = edit box variable
%          vmin   = minimum value of v
%          vmax   = maximum value for v
%          pos    = axes position vector
%          nbox   = number of edit boxes per column 
%          row    = row index of edit box (1 to nbox)
%          col    = column index of edit box (1 to 2)
%          fcolor = foreground color
%          bcolor = background color
%          cback  = callback string
%          tipstr = tool tip string
%          fsize  = font size
% Outputs:
%          h_edit = handle of edit box
%          dw     = horizontal spacing
%          dh     = vertical spacing

% Initialize

vstr = inputname(1);
white = [1 1 1];
waxis = pos(3);
haxis = pos(4);
wbox = 0.42*waxis;
dw = (waxis - 2*wbox)/3;
hbox = 0.20*haxis;
dh = (haxis - nbox*hbox)/(nbox+1);
pos0 = [pos(1)+dw+(col-1)*(wbox+dw), pos(2)+haxis-row*(dh+hbox), wbox, hbox];

% Create edit box

str_v = [vstr ' = ' mat2str(v) ';'];
cback1 = ['eval(get(gco,''String'')),' ...
           vstr '= f_clip(' vstr ',' mat2str(vmin) ',' mat2str(vmax) ');'...
           cback]; 
h_edit = uicontrol(gcf,...
   'Style','edit',...
   'FontName','FixedWidthFontName',...
   'FontSize',fsize,...
   'Units','normalized',...
   'Position',pos0,...
   'String',str_v,...
   'ForeGroundColor',fcolor,...
   'BackGroundColor',bcolor,...
   'Tooltipstring',tipstr,...
   'Visible','on',...
   'Callback',cback1);

%   'Fontname','FixedWidth',...
