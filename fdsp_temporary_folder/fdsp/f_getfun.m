function fname = f_getfun (default,prompt); 

%F_GETFUN: Prompt for the name of an M-file function 
%
% Usage: fname = f_getfun (default,prompt)
%
% Inputs: 
%         default = string containing name of default M_file function (no .M)
%         prompt  = prompt string
% Outputs: 
%          fname = string containing name of M-file
%
% Note: If fname is not in the MATLAB path, it is added to the path

% Remove extension from default

k = strfind (default,'.');
if ~isempty(k)
    default(k:end) = [];
end

% Get M-file name

ver  = version;
if all(ver(1:3) == '6.1')
    [fname,pname] = uigetfile ('.m',prompt);
else
    [fname,pname] = uigetfile ('.m',prompt,default);
end

% Check for bad response

if isequal(fname,0) 
   return
end

% Remove .m

k = strfind (fname,'.');
if ~isempty(k)
    fname(k:end) = [];
end

% Add file to path if needed

if exist([fname '.m']) ~= 2
   path(path,pname);
   fprintf ('\n%s has been added to the MATLAB path\n',pname)
end
