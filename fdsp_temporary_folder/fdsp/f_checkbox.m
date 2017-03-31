function hc_check = f_checkbox (c,pos,nrow,ncol,row,col,label,fcolor,bcolor,cback,tipstr,fsize)

%F_CHECKBOX: Create a check box control
%
% Usage: hc_check = f_checkbox (c,pos,nrow,ncol,row,col,label,fcolor,bcolor,cback,tipstr,fsize);
%
% Inputs: 
%           c      = value of check box variable (0 = unchecked, 1 = checked) 
%           pos    = position vector of axes
%           nrow   = number of rows of items
%           ncol   = number of columns of items
%           row    = row number (1 to nbox)
%           col    = column number (1 to 2)
%           dx     = x axis offset
%           dy     = y axis offset
%           label  = string containing check box label
%           fcolor = foreground color
%           bcolor = background color
%           cback  = callback string 
%           tipstr = tooltip string
%           fsize  = font size
% Outputs:
%           hc_check = handle to checkbox

% Initialize

cstr = inputname(1);
waxis = pos(3);
haxis = pos(4);
wbox = 0.84*waxis/ncol;
hbox = 0.13*haxis;
dw = (waxis - ncol*wbox)/(ncol+1);
dh = (haxis - nrow*hbox)/(nrow+1);
pos0 = [pos(1)+dw+(col-1)*(wbox+dw), pos(2)+haxis-row*(dh+hbox), wbox, hbox];

% Create check box

hc_check = uicontrol(gcf,...
   'Style','checkbox',...
   'Units','normalized',...
   'FontName','FixedWidthFontName',...
   'FontSize',fsize,...
   'Position',pos0,...
   'Value',c, ...
   'String',label,...
   'ForeGroundColor',fcolor,...
   'BackGroundColor',bcolor,...
   'Visible','on',...
   'Tooltip',tipstr);
cback1 = [cstr ' = 1 - ' cstr '; ' cback];
set (hc_check,'Callback',cback1)
