function hc_slider = f_slider (v,v_min,v_max,pos,fcolor,bcolor,cback,tipstr,dv,units,fsize)

%F_SLIDER: Create slider bar for GUI modules
%
% Usage: hc_slider = f_slider (v,v_min,v_max,pos,fcolor,bcolor,cback,tipstr,dv,units)
%
% Inputs: 
%         v      = slider variable
%         v_min  = lower limit slider variable
%         v_max  = upper limit of slider variable
%         pos    = position vector of axes
%         fcolor = foreground color for label
%         bcolor = background color
%         cback  = callback string
%         tipstr = tool tip string
%         dv     = an integer specifying the constraints on v
%
%                  0 = v is an integer
%                  1 = v is an even integer 
%                  2 = v is a power of 2
%
%         units  = units used to label the value of the slider variable
% Outputs: 
%          hc_slider  = array of handles to slider bar controls

vstr = inputname(1);
white = [1 1 1];
dx = 0.05*pos(3);
dy = 0.1*pos(4);
pos_slider = [pos(1)+dx,pos(2)+0.5*pos(4)-0.125*pos(4),pos(3)-2*dx,0.25*pos(4)]; 
cback1 = ['v = get(gco,''Value''); '...
          'if dv == 0, v = floor(v); end; '...
          'if dv == 1, v = 2*floor(v/2); end; '...
          'if dv == 2, v = 2^round(log(v)/log(2)); end; '...
          'set(gco,''Value'',v), '...
          [vstr ' = get(gco,''Value''); '] ...
          cback];
if dv == 0   
    step1 = 1 /(v_max - v_min);
else
    step1 = 2/(v_max - v_min);
end
step2 = 0.1*v_max/(v_max-v_min);

hc_slider(1) = uicontrol(gcf,...
   'Style','slider',...
   'Units','normalized',...
   'Position',pos_slider,...
   'Min',v_min,...
   'Max',v_max,...
   'Value',v,...
   'BackGroundColor',bcolor,...
   'Tooltipstring',tipstr,...
   'SliderStep',[step1 step2],...
   'Callback',cback1);

% Lower limit

pos_min = [pos_slider(1)-0.005  pos_slider(2)-0.022  0.02 0.02];
hc_slider(2) = uicontrol(gcf,'Style','text','Units','normalized','Position',pos_min,...
                         'FontName','FixedWidthFontName','FontSize',fsize,...
                         'String',num2str(v_min),'BackGroundColor',white);
                   
% Upper limit                   
                   
pos_max = [pos_slider(1)+pos_slider(3)-0.025 pos_slider(2)-0.022 0.032 0.02];
hc_slider(3) = uicontrol(gcf,'Style','text','Units','normalized','Position',pos_max,...
                         'FontName','FixedWidthFontName','FontSize',fsize,...
                         'String',num2str(v_max),'BackGroundColor',white);

% Button value                 
                 
pos_label = [pos(1)+0.5*pos(3)-0.05,pos(2)+0.70*pos(4),0.1,0.02];
x = floor(get(hc_slider(1),'Value'));
hc_slider(4) = uicontrol(gcf,'Style','text','Units','normalized','Position',pos_label,...
                         'FontName','FixedWidthFontName','FontSize',fsize,...
                         'String',[vstr ' = ' num2str(x) ' ' units],'ForeGroundColor',fcolor,...
                         'BackGroundColor',white,'HorizontalAlignment','center');
 