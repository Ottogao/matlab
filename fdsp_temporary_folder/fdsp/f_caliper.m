function [x,y] = f_caliper(k,disp)

%F_CALIPER: Measure coorinates on current plot using mouse
%
% Usage: [x,y] = f_caliper(k,disp)
%
% Inputs: 
%         k    = number of points measured.  
%         disp = an optional display code.  If disp ~= 0, then
%               the measured coordinates are displayed. 
% Outputs: 
%          x = k by 1 array containing x coordinates of points
%          y = k by 1 array containing y coordinates of points

% Initialize

k = f_clip (k,1,k);
if nargin < 2
   disp = 0;
end
x = zeros(k,1);
y = zeros(k,1);
close_msg = ['warndlg(''You must use the mouse crosshairs to select points on the plot before '''...
             '''closing the figure window'',''Usage of f_caliper.'')'];
set (gcf,'CloseRequestFcn',close_msg)

% Measure points

hold on
for i = 1 : k
     [x(i),y(i)] = ginput(1);
     plot (x(i),y(i),'k+')
     if disp
         s = sprintf ('  (x,y) = (%.2f,%.2f)',x(i),y(i));
         text (x(i),y(i),s)
     end
end
hold off
set (gcf,'CloseRequestFcn','closereq')

hold off
set (gcf,'CloseRequestFcn','closereq')

[q,matlab_version] = f_oldmat;
if matlab_version >= 7.0
    closereq
end
