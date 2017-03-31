% GUI module => g_filters
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
% 2. Use the slider bar to adjust the number of bits N 
%    used for coefficient quantization.
%
% 3. The User-defined filter option requires the name of a
%    MAT-file containing the coefficient vectors a and b, 
%    and the sampling frequency fs.
%
% 4. The Menu options include the following:
%
%    Realization => direct-form, cascade-form realizations
%    Save        => save x,y,a,b,fs in a MAT-file
%    Caliper     => find coordinates of points on the plot
%    Print       => send screen to printer or a file
%    Help        => user tips and GUI module help
%    Exit        => return to calling program
%
% 5. The FIR filters are windowed filters of order
%    m = 40 using the Hamming window.  See g_fir for 
%    more FIR filters.
%
% 6. The IIR filters are Butterworth filters whose
%    order is estimated based on the design 
%    specifications.  See g_iir for more IIR filters.
%
% 7. Direct-form realizations of IIR filters using low
%    precision and tight design specifications 
%    typically become unstable.  See g_iir for 
%    alternative designs. 