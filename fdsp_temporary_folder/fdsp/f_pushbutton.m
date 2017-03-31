function hc_push = f_pushbutton (pos,nrow,ncol,row,col,label,fcolor,bcolor,cback,tipstr,fsize,wbox,hbox);

%F_PUSHBUTTON: Create pushbutton control
%
% Usage: hc_push = f_pushbutton (pos,nrow,ncol,row,col,label,fcolor,bcolor,cback,tipstr,fsize,wbox,hbox);
%
% Inputs: 
%           pos    = position vector of axes
%           nrow   = number of rows of buttons
%           ncol   = number of columns of buttons
%           row    = row number (1 to nbut)
%           col    = column number (1 to 2) 
%           label  = string containing check box label
%           fcolor = foreground color
%           bcolor = background color
%           cback  = callback string when button is pushed
%           tipstr = tool tip string
%           fsize  = font size 
%           wbox   = optional width of box as a fraction of
%                    pos(3).  Default: 0.42
%           hbox   = optional height of box as a fraction of
%                    pos(4).  Default: 0.16
% Outputs: 
%           hc_push = handle of push button control

% Initialize

if (nargin < 12) | isempty(wbox)
    wbox = 0.42*pos(3);
end
if (nargin < 13) | isempty(hbox)
    hbox = 0.20*pos(4);
end
waxis = pos(3);
haxis = pos(4);
dw = (waxis - ncol*wbox)/(ncol+1);
dh = (haxis - nrow*hbox)/(nrow+1);
pos0 = [pos(1)+dw+(col-1)*(wbox+dw), pos(2)+haxis-row*(dh+hbox), wbox, hbox];

% Create pushbutton

hc_push = uicontrol(gcf,...
   'Style','pushbutton',...
   'Units','normalized',...
   'FontName','FixedWidthFontName',...
   'FontSize',fsize,...
   'Position',pos0,...
   'String',label,...
   'ForeGroundColor',fcolor,...
   'BackGroundColor',bcolor,...
   'Tooltipstring',tipstr,...
   'Visible','on',...
   'Callback',cback);
