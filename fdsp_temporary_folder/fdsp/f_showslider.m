function f_showslider (hs,han,v,units,display)

%F_SHOWSLIDER: Display the slider bar for GUI modules
%
% Usage: f_showslider (hs,han,v,units,display)
%
% Inputs: 
%         hs      = 1 by 4 array slider control handles
%         han     = array of axes handles 
%         v       = slider variable
%         units   = units for slider bar label
%         display = integer specifying display mode as follows;
%
%                   0 = slider not visible
%                   1 = slider visible

vstr = inputname(3);
if display
    set (han(5),'Visible','on')
    set (han(end),'Visible','on')
    set (hs,'Visible','on')
    set(hs(4),'String',[vstr ' = ' num2str(v) ' ' units]);
    set(hs(1),'Value',v);
else
    set (hs,'Visible','off')
    set (han(5),'Visible','off')
    set (han(end),'Visible','off')
end    
