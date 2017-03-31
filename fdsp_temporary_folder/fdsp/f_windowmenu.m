function hm_window = f_windowmenu (win,plotstr)

%F_WINDOWMENU: Set up data window menu item
%
% Usage: hm_window = f_winmenu (win,plotstr)
%
% Inputs: 
%         win     = data window type (0 to 3)
%         plotstr = callback string to regenerate plot 
% Outputs:
%          hm_window = array of menu handles

cstr = ['for i = 0 : 3, '...
        '   if i == win, '...
        '      set(hm_window(i+2),''Checked'',''on''), '...
        '   else, '...
        '      set(hm_window(i+2),''Checked'',''off''), '...
        '   end, '...
        'end, '...
        plotstr ];

hm_window(1) = uimenu (gcf,'Label','Window');

cback1 = ['win=0; ' cstr]; 
hm_window(2) = uimenu(hm_window(1),'Label','Rectangular window','Callback',cback1);

cback2 = ['win=1; ' cstr];
hm_window(3) = uimenu(hm_window(1),'Label','Hanning window','Callback',cback2);

cback3 = ['win=2; ' cstr];
hm_window(4) = uimenu(hm_window(1),'Label','Hamming window','Callback',cback3);

cback4 = ['win=3; ' cstr];
hm_window(5) = uimenu(hm_window(1),'Label','Blackman window','Callback',cback4);

for i = 0 : 3
  if i == win
     set(hm_window(i+2),'Checked','on')
  else
     set(hm_window(i+2),'Checked','off')
  end
end
