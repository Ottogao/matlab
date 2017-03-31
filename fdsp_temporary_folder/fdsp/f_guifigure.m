function [hfig,han,pos,colors,fsize] = f_guifigure (g_module)

%F_GUIFIGURE: Create figure window for specified GUI module
%
% Usage:   [hfig,han,pos,colors,fsize] = f_guifigure (g_module)
%
% Inputs: 
%          g_module = string containing name of GUI module
% Outputs:
%          hfig   = hand to figure window
%          han    = array of handles to tiled axes
%          pos    = array of position vectors for tiled axes
%          colors = array of plot colors
%          fsize  = recommended GUI font size in points

% Adjust font and figure size based on screen resolution

[fsize,horz,vert] = f_screen(1);
if fsize <= 7
    margin = 0.07;
elseif fsize == 8
    margin = 0.06;
elseif fsize == 9
    margin = 0.05;
else
    margin = 0.05;
end

% Create figure

side = 0;
hfig = figure('NumberTitle','off',...
              'Name',['GUI Module => ' g_module],...
              'MenuBar',menubar,...
              'Units','normalized',...
              'Position',[side, margin, 1-2*side, 1-2*margin]);

[q,matlab_version] = f_oldmat;
if matlab_version >= 7.0
    set (hfig,'DockControl','off')
end

% Compute dimensions of tiled axes 

screen = get(0,'Screensize');
dx = 0.06;
dy = 0.05*screen(3)/screen(4);
x1 = 0.5 - 1.5*dx;
x2 = 0.25 - 1.25*dx;
x3 = 1.0 - 2*dx;
x4 = 0.5 - dx;
y1 = 0.265 - 1.25*dy;
y2 = 0.235 - 1.25*dy;
y3 = 0.35 - 1.5*dy;
y4 = 0.15 - dy;
y5 = 0.5 - 2.0*dy;
y6 = 0.23 - dy;
pos = [dx,0.5+1.5*dy+y2,x1,y1
       dx,0.5+0.5*dy,x1,y2
       0.5+0.5*dx,0.5+1.5*dy+y4,x2,y3
       0.5+1.5*dx+x2,0.5+1.5*dy+y4,x2,y3
       0.5+0.5*dx,0.5+0.5*dy,x1,y4
       dx,dy,x3,y5
       dx,dy,x4,y5
       0.5,dy,x4,y5
       dx,.5-y6-dy,x3,y6
       dx,dy,x3,y6];
n = size(pos,1);   
white = [1 1 1];
aspect = (pos(1,3)/pos(1,4))*(screen(3)/screen(4));

% Create tiled axes

gmodule = f_cleanstring(g_module);
for i = 1 : n
    han(i) = axes('Position',pos(i,:),'FontName','FixedWidthFontName',...
                  'FontSize',fsize);
    axis ([0 1 0 1])
    if (i == 1) 
        colors = get(gca,'ColorOrder');
        axis ([0 1 0 1/aspect]);
    end        
    set (han(i),'Xtick',[])
    set (han(i),'Ytick',[])
    set (han(i),'Color',white)
    switch (i)
        case 1, han(n+i) = text (0.5,1.08/aspect,gmodule,'HorizontalAlignment','center',...
                      'Color',colors(1,:),'FontName','FixedWidthFontName','FontSize',fsize);
        case 2, han(n+i) = text (0.5,1.10,'Edit parameters','HorizontalAlignment','center',...
                      'Color',colors(2,:),'FontName','FixedWidthFontName','FontSize',fsize);
        case 3, han(n+i) = text (0.5,1.05,'Select type','HorizontalAlignment','center',...
                      'Color',colors(3,:),'FontName','FixedWidthFontName','FontSize',fsize);
        case 4, han(n+i) = text (0.5,1.05,'Select view','HorizontalAlignment','center',...
                      'Color',colors(3,:),'FontName','FixedWidthFontName','FontSize',fsize);
        case 5, han(n+i) = text (0.5,1.15,'Slider bar','HorizontalAlignment','center',...
                      'Color',colors(1,:),'FontName','FixedWidthFontName','FontSize',fsize);
    end
    box on
end
