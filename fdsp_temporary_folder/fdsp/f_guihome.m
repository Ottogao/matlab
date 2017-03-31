function [hfig,han,pos,colors,ht,fsize] = f_guihome

%F_GUIHOME: Create figure window for the homework builder module
%
% Usage:   [hfig,han,pos,colors,fsize] = f_guihome
%
% Outputs:
%          hfig   = hand to figure window
%          han    = array of handles to tiled axes
%          pos    = array of position vectors for tiled axes
%          colors = array of plot colors
%          ht     = array of handles to text objects
%          fsize  = font size

[fsize,horz,vert] = f_screen(1);
margin = 0.06;
hfig = figure('NumberTitle','off',...
              'Name','Homework Builder Module => g_homework',...
              'MenuBar',menubar,...
              'Units','normalized',...
              'Position',[margin,margin,1-2*margin,1-2*margin],...
              'PaperPosition',[.5,1,7.5,9]);

[q,matlab_version] = f_oldmat;
if matlab_version >= 7.0
    set (hfig,'DockControl','off')
end

% Compute dimensions of tiled axes 

screen = get(0,'Screensize');
dx = 0.03;
dy = 0.02*screen(3)/screen(4);
x1 = 0.4 - 1.5*dx;
x2 = x1;
x3 = 0.6 - 1.5*dx;
y1 = 0.42;
y2 = 0.42;
y3 = 0.9;
pos = [dx,dy+y2+(y3-y1-y2),x1,y1
       dx,dy,x2,y2
       0.4+dx/2,dy,x3,y3];
n = size(pos,1);   
white = [1 1 1];

% Create tiled axes

for i = 1 : n
    han(i) = axes('Position',pos(i,:));
    axis ([0 1 0 1])
    if (i <= 2) 
        colors = get(gca,'ColorOrder');
    end        
    set (han(i),'Xtick',[])
    set (han(i),'Ytick',[])
    set (han(i),'Color',white)
    switch (i)
        case 1, ht(1) = text (0.5,1.04,'Create homework assignment','HorizontalAlignment','center',...
                              'Color',colors(1,:),'FontName','FixedWidthFontName','FontSize',fsize);
        case 2, ht(2) = text (0.5,1.04,'Select homework problems','HorizontalAlignment','center',...
                              'Color',colors(2,:),'FontName','FixedWidthFontName','FontSize',fsize);
    end
    box on
end
