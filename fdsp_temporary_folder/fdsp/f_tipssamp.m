% GUI module => g_sample
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with 
%    the Enter key.
%
%    n  = anti-aliasing filter order (0 = no filter)
%    Fc = anti-aliasing filter cutoff frequency
%    N  = number of bits of precision of ADC
%    Vr = reference voltage of ADC
%
% 2. To change the sampling frequency, use the slider bar.
%
% 3. For the User-defined input, you must supply the name
%    of an M-file function that returns the analog input
%    signal value x = ufun(t).  For example:
%
%    function x = ufun(t)
%       x = t .* exp(-t);
%
% 4. The Menu options include the following:
%
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
