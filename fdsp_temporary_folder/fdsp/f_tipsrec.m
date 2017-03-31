% GUI module => g_reconstruct
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with
%    the Enter key.
%
%    N  = number of bits of precision of DAC
%    Vr = reference voltage of DAC
%    n  = anti-imaging filter order (0 = no filter)
%    Fc = anti-imaging filter cutoff frequency
%
% 2. To change the sampling frequency, user the slider bar.
%
% 3. For the User-defined input, you must supply the file
%    name of a MATLAB M-file function that returns the analog
%    signal value y = ufun(t).  For example,
%
%    function y = ufun(t)
%       y = exp(-t) .* sin(2*pi*t);
%
% 4. The Menu options include the following:
%
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
 