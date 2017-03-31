% GUI Module => g_system
%
% User Tips
%
% 1. All changes to edit box parameters are activated with
%    the Enter key.
%
%      a  = vector of denominator coefficients, a(1) = 1
%      b  = vector of numerator coefficients
%      c  = damping factor of damped cosine input
%      f0 = frequency of damped cosine input (0 to fs/2)
%      fs = sampling frequency
%
% 2. Use the slider bar to adjust the number of samples N.
%
% 3. For the User-defined input, you must supply the file 
%    name of a MAT-file that contains the input vector x, 
%    the sampling frequency fs, and the coefficient vectors
%    a and b.
%
% 4. The Menu options include the following:
%
%    Save    => save x,y,a,b,fs in a MAT-file
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
