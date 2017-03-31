% GUI Driver module => f_dsp
%
% User Tips:
% 
% 1. To return to the f_dsp window from a GUI module, 
%    Example,Figure, Problem, or Help window, close 
%    that window. 
%
% 2. For MATLAB 6.5 or later, it is recommended that you 
%    undock the help window (arrow in upper-right corner).
%
% 3. The Problems menu provides solutions to selected 
%    problems using PDF files. To activate this feature, 
%    you must have an Adobe Acrobat reader program 
%    installed, and you must register that reader with
%    the FDSP toolbox using the Problems/Register menu 
%    option.
% 
% 4. Most of the GUI modules can communicate with one 
%    another through MAT-files using the User-defined 
%    input and Save options.  The standardized MAT-file 
%    format contains parameters {x,y,a,b,fs} where 
%    H(z) = B(z)/A(z). Here:
%
%       x  => vector of input samples
%       y  => vector of output samples
%       a  => denominator coefficient vector, a(1) = 1
%       b  => numerator coefficient vector
%       fs => sampling frequency in Hz
%
%    Most GUI modules make use of a subset of the 
%    parameters. However, a MAT-file that contains all 
%    five parameters is readable by every GUI module.
%
% 5. GUI modules g_sample, g_reconstruct, and g_fir use
%    M-file functions for the User-defined input option, 
%    rather than MAT-files. M-file functions for g_sample
%    and g_reconstruct are compatible with one another 
%    because both specify time signals as x = ufun(t). 
%    The M-file function for g_fir specifies a desired 
%    amplitude response as A = ufun(f,fs).
%
% 6. The GUI modules were developed using a screen 
%    resolution of 1280 x 1024 pixels.  To change your
%    screen resolution to something approximately similar
%    or higher: exit MATLAB, right click on the desktop, 
%    and select Properties/Settings.
