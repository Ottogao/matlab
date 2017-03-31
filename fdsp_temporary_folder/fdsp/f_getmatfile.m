function [user,path] = f_getmatfile (caption,default); 

%F_GETNATFILE: Prompt the user for the name of an M-file function
%
% Usage: [user,path] = f_getmatfile (caption,default)
%
% Inputs: 
%         caption = prompt string
%         default = string containing name of default MAT-file  
% Outputs: 
%          user = string containing name of MAT-file 
%          path = string containing path of MAT-file
%
% Note: If cancel button is choosen, user = path = 0
%
% See also: F_GETMFILE

ver  = version;
if all(ver(1:3) == '6.1')
    [user,path] = uigetfile ('*.mat',caption);
else
    [user,path] = uigetfile ('*.mat',caption,default);
end
 