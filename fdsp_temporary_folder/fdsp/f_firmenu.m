function hm_fir = f_firmenu (inputstr,plotstr,method,mtitle)

%F_FIRMENU: Set up FIR filter design method menu
%
% Usage: hm_fir = f_firmenu (inputstr,plotstr,method,mtitle)
%
% Inputs: 
%         inputstr = callback string to compute input
%         plotstr  = callback string to generate plot
%         method   = FIR filter design method
%         mtitle   = menu title
% Outputs:
%          hm_fir = array of menu handles

cstr = ['for i = 0 : 6, '...
        '   if i == method, '...
        '       set(hm_fir(i+2),''Checked'',''on''), '...
        '   else, '...
        '       set(hm_fir(i+2),''Checked'',''off''), '...
        '   end, '... 
        'end, '...
        'f_type = method; '...                                    % used by g_multirate
        inputstr ...
        plotstr];

hm_fir(1) = uimenu (gcf,'Label',mtitle);
   
cback1 = ['method=0; win=0; ' cstr]; 
hm_fir(2) = uimenu (hm_fir(1),	'Label','Windowed filter: rectangular','Callback',cback1);

cback2 = ['method=1; win=1; ' cstr];
hm_fir(3) = uimenu (hm_fir(1),	'Label','Windowed filter: Hanning','Callback',cback2);

cback3 = ['method=2; win=2; ' cstr];
hm_fir(4) = uimenu (hm_fir(1),	'Label','Windowed filter: Hamming','Callback',cback3);

cback4 = ['method=3; win=3; ' cstr];
hm_fir(5) = uimenu (hm_fir(1),	'Label','Windowed filter: Blackman','Callback',cback4);

cback5 = ['method=4; ' cstr];
hm_fir(6) = uimenu (hm_fir(1),	'Label','Frequency-sampled filter','Callback',cback5);

cback6 = ['method=5; ' cstr];
hm_fir(7) = uimenu (hm_fir(1),	'Label','Least-squares filter','Callback',cback6);

cback7 = ['method=6; ' cstr];
hm_fir(8) = uimenu (hm_fir(1),	'Label','Equiripple filter','Callback',cback7);

for i = 0 : 6
    if i == method
        set (hm_fir(i+2),'Checked','on')
    else
        set (hm_fir(i+2),'Checked','off')
    end
end