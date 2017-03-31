% GUI module => g_iir
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with
%    the Enter key.
%
%    F_0     = lower cutoff frequency
%    F_1     = upper cutoff frequency
%    B       = width of transition band
%    fs      = sampling frequency
%    delta_p = passband ripple
%    delta_s = stopband attenuation
%
% 2. The resonator and notch frequencies are the average
%    of F_0 and F_1 
%
% 3. Use the slider bar to adjust the IIR filter order n.
%
% 4. The User-defined filter type option requires the name of
%    a MAT-file containing the coefficient vectors a and b, 
%    and the sampling frequence fs.
%
% 5. The Menu options include the following:
%
%    Prototype => analog prototype filter
%    Save      => save x,y,a,b,fs in a MAT-file
%    Caliper   => find coordinates of points on the plot
%    Print     => send screen to printer or a file
%    Help      => user tips and GUI module help
%    Exit      => return to calling program
