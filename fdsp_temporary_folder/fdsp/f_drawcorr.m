function f_drawcorr (h,colors,circ,norm,pv,fsize)

%F_DRAWCORR: Draw a block diagram for GUI module g_correlate
%
% Usage: f_drawcorr (h,colors,circ,norm,pv,fsize);
%
% Inputs: 
%         h      = axes handle
%         colors = array of plotting colors
%         circ   = circular mode (0 = linear, 1 = circular)
%         norm   = normalization (0 = unnormalized, 1 = normalized)
%         pv     = plot view
%         fsize  = font size

% Initialize

ylim = get(h,'Ylim');
xlim = get(h,'Xlim');
y0 = (ylim(2)-ylim(1))/2;
axes (h);
hold on
arrow = 0.1;
boxwidth = 0.2;
boxheight = 0.2;
circle = 0.02;
dy = 0.2;
dy2 = 0.15;
cla

% Label block and output

switch (pv)
case {1,2},                                % convolution
    
   f_circle (0.5-arrow-0.5*boxwidth,y0,circle,colors(1,:));
   text (0.5-arrow-0.5*boxwidth-0.04,y0,'x(k)','Color',colors(1,:),'HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize);
   f_vector (0.5-arrow-0.5*boxwidth+0.5*circle,y0,1,0,arrow-0.5*circle,colors(1,:))
   f_block (0.5-0.5*boxwidth,y0-0.5*boxheight,boxwidth,boxheight,colors(2,:))
   f_line (0.5+0.5*boxwidth,y0,1,0,arrow-0.5*circle,colors(3,:))
   f_circle (0.5+0.5*boxwidth+arrow,y0,circle,colors(3,:))
   if circ
      text (0.5,y0+dy2*boxheight,'Circular','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy2*boxheight,'convolution','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5+0.5*boxwidth+arrow+0.070,y0,'x(k)\circy(k)','Color',colors(3,:),...
            'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
   else
      text (0.5,y0+dy2*boxheight,'Linear','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy2*boxheight,'convolution','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5+0.5*boxwidth+arrow+0.070,y0,'x(k)*y(k)','Color',colors(3,:),...
            'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
   end

case 3,                                    % cross-correlation                         
    
   f_circle (0.5-arrow-0.5*boxwidth,y0+dy*boxheight,circle,colors(1,:));
   text (0.5-arrow-0.5*boxwidth-0.04,y0+dy*boxheight,'x(k)','Color',colors(1,:),...
         'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
   f_vector (0.5-arrow-0.5*boxwidth+0.5*circle,y0+dy*boxheight,1,0,arrow-0.5*circle,colors(1,:))
   f_circle (0.5-arrow-0.5*boxwidth,y0-dy*boxheight,circle,colors(2,:));
   text (0.5-arrow-0.5*boxwidth-0.04,y0-dy*boxheight,'y(k)','Color',colors(2,:),...
         'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
   f_vector (0.5-arrow-0.5*boxwidth+0.5*circle,y0-dy*boxheight,1,0,arrow-0.5*circle,colors(2,:))
   f_block (0.5-0.5*boxwidth,y0-0.5*boxheight,boxwidth,boxheight,colors(2,:))
   f_line (0.5+0.5*boxwidth,y0,1,0,arrow-0.5*circle,colors(3,:))
   f_circle (0.5+0.5*boxwidth+arrow,y0,circle,colors(3,:))
   if circ
      text (0.5,y0+dy*boxheight,'Circular','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0,'cross-','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy*boxheight,'correlation','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      if norm
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'\sigma_{xy}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      else
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'c_{xy}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      end    
   else
      text (0.5,y0+dy*boxheight,'Linear','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0,'cross-','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy*boxheight,'correlation','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      if norm
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'\rho_{xy}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      else
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'r_{xy}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      end
   end
   
case 4,                                     % auto-correlation 

    f_circle (0.5-arrow-0.5*boxwidth,y0,circle,colors(1,:));
    text (0.5-arrow-0.5*boxwidth-0.04,y0,'x(k)','Color',colors(1,:),...
          'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
    f_vector (0.5-arrow-0.5*boxwidth+0.5*circle,y0,1,0,arrow-0.5*circle,colors(1,:))
    f_block (0.5-0.5*boxwidth,y0-0.5*boxheight,boxwidth,boxheight,colors(2,:))
    f_line (0.5+0.5*boxwidth,y0,1,0,arrow-0.5*circle,colors(3,:))
    f_circle (0.5+0.5*boxwidth+arrow,y0,circle,colors(3,:))
    if circ
      text (0.5,y0+dy*boxheight,'Circular','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0,'auto-','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy*boxheight,'correlation','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      if norm
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'\sigma_{xx}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      else
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'c_{xx}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      end    
   else
      text (0.5,y0+dy*boxheight,'Linear','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0,'auto-','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      text (0.5,y0-dy*boxheight,'correlation','HorizontalAlignment','center',...
            'FontName','FixedWidthFontName','FontSize',fsize)
      if norm
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'\rho_{xx}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      else
         text (0.5+0.5*boxwidth+arrow+0.055,y0,'r_{xx}(k)','Color',colors(3,:),...
               'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
      end
   end

case 5,                                          % power density spectrum   
 
   f_circle (0.5-1.5*arrow-boxwidth,y0,circle,colors(1,:));
   text (0.5-1.5*arrow-boxwidth-0.035,y0,'x(k)','Color',colors(1,:),...
         'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
   f_vector (0.5-1.5*arrow-boxwidth+0.5*circle,y0,1,0,arrow-0.5*circle,colors(1,:))
   f_block (0.5-0.5*arrow-boxwidth,y0-0.5*boxheight,boxwidth,boxheight,colors(2,:))
   text (0.5-0.5*arrow-0.5*boxwidth,y0+0.25*boxheight,'Circular','HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize)
   text (0.5-0.5*arrow-0.5*boxwidth,y0,'auto-','HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize)
   text (0.5-0.5*arrow-0.5*boxwidth,y0-0.25*boxheight,'correlation','HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize)
   f_vector (0.5-0.5*arrow,y0,1,0,arrow,colors(2,:))
   text (0.5,1.20*y0,'c_{xx}','Color',colors(2,:),'HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize);
   f_block (0.5+0.5*arrow,y0-0.5*boxheight,boxwidth,boxheight,colors(3,:))
   text (0.5+0.5*arrow+0.5*boxwidth,y0,'DFT','HorizontalAlignment','center',...
         'FontName','FixedWidthFontName','FontSize',fsize)
   f_line (0.5+0.5*arrow+boxwidth,y0,1,0,arrow-0.5*circle,colors(3,:))
   f_circle (0.5+1.5*arrow+boxwidth,y0,circle,colors(3,:))
   text (0.5+1.5*arrow+boxwidth+0.045,y0,'S_L(f)','Color',colors(3,:),...
         'HorizontalAlignment','center','FontName','FixedWidthFontName','FontSize',fsize);
 
end 
