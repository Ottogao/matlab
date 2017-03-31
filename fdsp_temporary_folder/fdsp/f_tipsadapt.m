% GUI module => g_adapt
%
% User tips:
% 
% 1. All changes to edit box parameters are activated with
%    the Enter key.
%
%    a     = denominator polynomial coefficients of black box
%    b     = numerator polynomial coefficients of block box
%    fs    = sampling frequency in Hz
%    N     = number of samples
%    mu    = step size
%    nu    = leakage factor
%    alpha = normalized step size
%    beta  = smoothing factor
%
% 2. Use the Slider bar to adjust the transversal filter 
%    order m.
%
% 3. The Data source checkbox requires the name of a used 
%    supplied MAT-file containing the input vector x, and
%    the desired output vector y.  Once y is loaded, it is
%    changed to d, and a new y is computed.
%
% 4. The Menu options include the following:
%
%    Save    => save x,y,a,b,fs in a MAT-file with y = d
%    Caliper => find coordinates of points on the plot
%    Print   => send screen to printer or a file
%    Help    => user tips and GUI module help
%    Exit    => return to calling program
