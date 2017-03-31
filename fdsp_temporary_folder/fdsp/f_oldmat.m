function [y,vernum] = f_oldmat

%F_OLDMAT: Check to see if MATLAB version is too old
%
% Usage: [y,vernum] = oldmat
%
% Outputs: 
%          y      = 1 if too old, 0 if ok.
%          vernum = version number
%
% Note: This is used by the GUI modules

matlab_ver = 6.1;
ver = version;
vernum = str2num(ver(1:3));
if vernum < matlab_ver
   fprintf ('\nThis GUI module requires MATLAB Version %.1f or later.',matlab_ver);
   y = 1;
else
   y = 0;
end
