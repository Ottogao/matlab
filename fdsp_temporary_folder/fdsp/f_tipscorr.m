% GUI module => g_correlate
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with 
%    the Enter key.
%
%    L = length of input x
%    M = length of input y where M <= L
%    a = amplitude of second term of signal x
%
% 2. For the white noise input, a scaled and delayed version 
%    of the short signal y is added to the long signal x. 
%    Use the slider bar to adjust the delay d.
%
%    x(k) = v(k) + a*y(k-d)
%
% 3. For the User-defined inputs, you must supply the file
%    name of a MAT-file that contains vectors x and y and
%    the sampling frequency fs.
%
% 4. The Menu options include the following:
%
%    Save    => save x,y,a,b,fs in a MAT-file
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program

