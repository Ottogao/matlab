function hm_save = f_savemenu (userinput,savestr,label)

%F_SAVEMENU: Create save menu item
%
% Usage: hm_save = f_savemenu (userinput,savestr,label)
%
% Inputs: 
%         userinput = string containing name of default file
%         savestr   = string of varible names to be saved 
%         label     = menu label 
% Outputs:
%          hm_save = menu handle

if isempty(savestr)
    savestr = '''a'',''b'',''x'',''y'',''fs''';
end
if isempty(label)
   hm_4= gcf;
   label = 'Save homework';
else
   hm_4 = uimenu (gcf,'Label','Save');
end
cback_save = ['[ufname,upath] = uiputfile(''*.mat'',''Select MAT-file'',userinput);'...
              'if ufname == 0, return, end; '...
              'userinput = [upath ufname]; '...
              'savestr = get(hm_save,''UserData''); '...
              'save(userinput,' savestr ')'];
hm_save = uimenu (hm_4,'Label',label,'Callback',cback_save,'UserData',savestr);
