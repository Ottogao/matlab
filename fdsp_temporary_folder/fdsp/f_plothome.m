function hv = f_plothome (han,course,homework,due,sec,problems,prob,show_sec,fsize)

%F_PLOTHOME: Draw the homework assignment in display window
%
% Usage: hv = f_plothome (han,course,homework,due,sec,problems,prob,show_sec)
%
% Inputs: 
%          han         = array of axes handles
%          course      = string containing course name
%          homework    = string containing homework number
%          due         = string containing due date
%          sec         = 1 by 2 cell array of strings containing section numbers
%          problems    = n by 4 cell array of problems
%          prob        = array of length np containing subscripts
%                        of selected problems
%          show_sec    = show the section number for each homework
%                        problem if nonzero.
%          fsize       = font size
%
% Outputs:
%          hv          = handle to text object

% Initialize

colors = get(gca,'ColorOrder');
axes (han(3))
prob_type = {'Analysis','GUI Simulation','Computation'};
cla

% Title 

hv = text (0.4,1.02,'View homework assignment','HorizontalAlignment','center',...
           'Color',colors(1,:),'FontName','FixedWidthFontName','FontSize',fsize);

% List course information

dx = 0.12;
dx2 = 0.28;
dy = 0.04;
htitle = text (0.5,1-2*dy,course,...
               'HorizontalAlign','center',...
               'Color','r',...
               'Fontsize',18);
text (dx,1-4*dy,'Homework:','Color','k','FontName','FixedWidthFontName','FontSize',fsize);
text (dx2,1-4*dy,homework,'Color','r','FontName','FixedWidthFontName','FontSize',fsize);
text (dx,1-5*dy,'Due Date:','Color','k','FontName','FixedWidthFontName','FontSize',fsize);
text (dx2,1-5*dy,due,'Color','r','FontName','FixedWidthFontName','FontSize',fsize);
if show_sec  
   text (dx,1-6*dy,'Sections:','Color','k','FontName','FixedWidthFontName','FontSize',fsize);
   text (dx2,1-6*dy,[sec{1} ' to ' sec{2}],'Color','r','FontName','FixedWidthFontName','FontSize',fsize);
end
 
% List problems

np = length (prob);
dy1 = 0.8/(np+4);
for i = 1 : np
    k = prob(i);
    secstr = problems{k,1};
    pnum = problems{k,2};
    ptype = problems{k,3};
    s = sprintf ('%d.  Do %s problem %s ',i,prob_type{ptype},pnum);
    if show_sec
        s = [s sprintf(' (Section %s)',secstr)];
    end
    text (dx,1-6*dy-(i+1)*dy1,s,'FontName','FixedWidthFontName','FontSize',fsize)
end
 