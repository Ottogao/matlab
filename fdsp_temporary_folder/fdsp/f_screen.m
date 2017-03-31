function [fsize,horz,vert] = f_screen (warn)

%F_SCREEN: Compute the current graphics screen resolution
%
% Usage: [fsize,horz,vert] = f_screen (warn);
%
% Inputs:
%          warn = optional input.  If warn is present and 
%                 nonzero, issue a warning if the screen
%                 resolution is too low for the GUI
%                 modules (below 1024 x 768).
% Outputs: 
%          fsize = suggested fontsize, in points, for the
%                  GUI module text labels
%          horz  = horizontal resolution in  pixels
%          vert  = resolution in pixels

% Get screen resolution

screen = get (0,'ScreenSize');
horz = screen(3);
vert = screen(4);
horz_nom = 1280;
vert_nom = 1024;

% Set recommended font size

if (horz <= 640) | (vert <= 480)
    fsize = 7;
elseif (horz <= 800) | (vert <= 600)
    fsize = 8;
elseif (horz <= 1024) | (vert <= 768)
    fsize = 9;
else
    fsize = 10;
end
 
% Issue warning if resolution is too low

if nargin < 1
    warn = 0;
end
swarn = getpref ('FDSP_preferences','screen_warning');
if warn & swarn
   msg = sprintf (['The GUI module screens have been designed to use a\n'...
                   'screen resolution of %d x %d.  The current screen\n'...
                   'resolution is %d x %d pixels.  To reset your screen\n'...
                   'resolution: exit MATLAB, right click on the desktop, and\n'...
                   'select Properties/Settings.'],horz_nom,vert_nom,horz,vert);
   if (horz < horz_nom) | (vert < vert_nom)
     reply = questdlg (msg,'Screen Resolution Warning','Disable this warning',...
                       'Continue','Continue');
     if strcmp (reply,'Disable this warning')
         setpref ('FDSP_preferences','screen_warning',0)
     end
   end
end

