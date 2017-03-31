% GUI module => g_spectra
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with 
%    the Enter key.
%
%    fs = sampling frequency
%    fa = frequency of cosine input
%    c  = amplitude of additive uniform white noise
%    d  = clipping threshold for x(k)
%
% 2. Use the slider bar to adjust the number of samples N.
%
% 3. For the User-defined input, you must supply the file
%    name of a MAT-file that contains input vector x and 
%    the sampling frequency fs.
%
% 4. The Menu options include the following:
%
%    Window  => window used for power density spectrum
%    Save    => save x,y,a,b,fs in a MAT-file
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
