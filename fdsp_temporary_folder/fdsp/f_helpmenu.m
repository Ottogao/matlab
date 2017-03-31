function f_helpmenu (tips,g_module)

%F_HELPMENU: Set up help menu item
%
% Usage: f_helpmenu (tips,about,g_module)
%
% Inputs: 
%         tips     = string specifying name of file containing user tips
%         g_module = string specifying name of GUI module
         
hm_3 = uimenu (gcf,'Label','Help');
cback = ['h_fig = gcf; set(h_fig,''Selected'',''off''); '...
         'helpwin ' tips '; '...
         'set(h_fig,''Selected'',''on'')'];
hm_31 = uimenu (hm_3,'Label','User tips','Callback',cback);
cback = ['h_fig = gcf; '...
         'set(h_fig,''Selected'',''off''); '...
         'helpwin ' g_module ...
         ' set(h_fig,''Selected'',''on''), '...
         'refresh(h_fig)' ];
hm_32 = uimenu (hm_3,'Label',['About ' g_module],'Callback',cback,'Separator','on');
