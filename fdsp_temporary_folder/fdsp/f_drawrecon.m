function f_drawrecon (h,colors,fsize)

%F_DRAWRECON: Draw a block diagram for GUI module g_reconstruct
%
% Usage:   f_drawrecon (h,colors,fsize);
%
% Inputs: 
%         h      = axis handle
%         colors = array of plotting colors
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

% Draw block diagram

f_circle (0.5-1.5*arrow-boxwidth,y0,circle,colors(3,:));
text (0.5-1.5*arrow-boxwidth-0.03,y0,'y','Color',colors(3,:),'HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize);
f_vector (0.5-1.5*arrow-boxwidth+0.5*circle,y0,1,0,arrow-0.5*circle,colors(3,:))
f_block (0.5-0.5*arrow-boxwidth,y0-0.5*boxheight,boxwidth,boxheight,colors(2,:))
text (0.5-0.5*arrow-0.5*boxwidth,y0,'DAC','HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize)
f_vector (0.5-0.5*arrow,y0,1,0,arrow,colors(2,:))
text (0.5,1.20*y0,'y_b','Color',colors(2,:),'HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize);
f_block (0.5+0.5*arrow,y0-0.5*boxheight,boxwidth,boxheight,colors(1,:))
text (0.5+0.5*arrow+0.5*boxwidth,y0+0.25*boxheight,'Anti-','HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize)
text (0.5+0.5*arrow+0.5*boxwidth,y0,'imaging','HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize)
text (0.5+0.5*arrow+0.5*boxwidth,y0-0.25*boxheight,'filter','HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize)
f_line (0.5+0.5*arrow+boxwidth,y0,1,0,arrow-0.5*circle,colors(1,:))
f_circle (0.5+1.5*arrow+boxwidth,y0,circle,colors(1,:))
text (0.5+1.5*arrow+boxwidth+0.03,y0,'y_a','Color',colors(1,:),'HorizontalAlignment','center',...
      'FontName','FixedWidthFontName','FontSize',fsize);
 