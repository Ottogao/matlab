function dy = f_butter (t,y,flag,b,a,xm,userinput,X)

%F_BUTTER: ODE file for Butterworth lowpass analog filter 
%
% Usage: dy = f_butter (t,y,flag,b,a,xm,userinput,X)
%
% Inputs: 
%         t         = evaluation time 
%         y         = n by 1 state vector
%         flag      = see help odefile
%         b         = numerator coefficient of filter
%         a         = denominator coefficient vector of filter
%         xm        = input mode
%         userinput = string containing name of user-defined input
%                     function: x = userinput(t)
%         X         = p by 2 array containing breakpoints for piecewise-
%                     linear input (optional)
% Outputs: 
%          dy = an n by 1 vector containing the derivative 
%               of y with respect to t at (t,y).
%
% Notes: Used by chapter GUI modules g_sample and g_reconstruct

n = length(a)-1;
x0 = f_funx(t,xm,userinput,X);
c = f_torow(a(n+1:-1:2));
dy = [y(2:n) ; b(1)*x0-(c*y)/a(1)];
 