% GUI module => g_multirate
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with
%    the Enter key.
%
%    fs = sampling frequency of x
%    L  = integer interpolation factor
%    M  = integer decimation factor
%    c  = damping factor for damped cosine input
%
% 2. Use the slider bar to adjust the FIR filter order m.
%
% 3. The User-defined input option requires the name of a
%    MAT-file that contains the vector x and the sampling 
%    frequency fs.
%
% 4. The Menu options include the following:
%
%    Filter  => design method for rate converter filter
%    Save    => save x,y,a,b,fs in a MAT-file
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
