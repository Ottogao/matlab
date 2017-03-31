function v = f_version (s)

%F_VERSION: Return version number of requested item
%
% Usage: v = f_version (s)
%
% Inputs: 
%          s = an optional string specifying the item whose 
%              version is being requested.  Default = 'MATLAB'
%
%              'MATLAB' = MATLAB verison number
%              'FDSP'   = FDSP version number
% Outputs:
%          v = a double containing a two-digit version number
%              of the requested item

if nargin < 1
   s = 'MATLAB';
end

if strcmp(s,'MATLAB') 
   q = version;
   v = str2num (q(1:3));
end

if strcmp(s,'FDSP')
    v = 1.0;
end
