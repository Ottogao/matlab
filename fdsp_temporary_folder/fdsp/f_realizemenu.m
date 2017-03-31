function hm_realize = f_realizemenu (inputstr,plotstr,realize)

%F_REALIZEMENU: Set up filter realization menu 
%
% Usage: hm_realize = f_realizemenu (inputstr,plotstr,realize)
%
% Inputs: 
%         inputstr = callback string to compute input
%         plotstr  = callback string to generate plot 
%         realize  = realization method (0=direct,1=cascade)
% Outputs:
%          hm_realize = array of menu handles

cstr = ['for i = 0 : 1, '...
        '   if i == realize, '...
        '       set (hm_realize(i+2),''Checked'',''on''), '...
        '   else, '...
        '       set (hm_realize(i+2),''Checked'',''off''), '...
        '   end, '...
        'end, '...
        inputstr ...
        plotstr ];

hm_realize(1) = uimenu (gcf,'Label','Realization');
   
cback1 = ['realize=0; ' cstr];
hm_realize(2) = uimenu (hm_realize(1),'Label','Direct form','Callback',cback1);
      
cback2 = ['realize=1; ' cstr];
hm_realize(3) = uimenu (hm_realize(1),'Label','Cascade form','Callback',cback2);

for i = 0 : 1
    if i == realize
        set (hm_realize(i+2),'Checked','on')
    else
        set (hm_realize(i+2),'Checked','off')
    end
end
 