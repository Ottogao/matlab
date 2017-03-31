% GUI module => g_fir
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
% 2. Use the slider bar to adjust the FIR filter order m.
%
% 3. The User-defined filter type requires the name of an
%    M-file function that returns the desired amplitude 
%    response, A = ufun(f,fs).  When f is a vector of 
%    evaluation frequencies, A should be a vector of the 
%    same size. For example:
%
%    function A = ufun(f,fs)
%       u = f/fs;     
%       A = u ./ (1 + u.^2);
%
% 4. The Menu options include the following:
%
%    Method  => FIR filter design method
%    Save    => save x,y,a,b,fs in a MAT-file
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
