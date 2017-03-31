function f_exitmenu 

%F_EXITMENU: Create exit menu item
%
% Usage: f_exitmenu 
%
uimenu (gcf,'Label','Exit','Callback','close; clc; return');
