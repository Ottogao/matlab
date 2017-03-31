function x = f_funx (t,xm,userinput,X)

%F_FUNX: Compute a selected input signal
%
% Usage: x = f_funx(t,xm,userinput,X);
%
% Inputs: 
%         t         = evaluation time 
%         xm        = input mode
%         userinput = a string specifying the name of a user
%                     defined function: x = userinput(t)
%         X         = p by 2 array containing breakpoints for
%                     piecewise-constant input (optional)
% Outputs: 
%          x = value of input signal at time t
%
% Note: Used by f_plotsamp, and f_plotrec

x = 0;
switch xm
   
case 0,                               % piecewise-linear (used by 
   p = size(X,1);                     % Butterworth)
   dt = (X(p,1)-X(1,1))/(p-1);
   k = 1 + floor((t - X(1,1))/dt);
   k = max(1,min(p-1,k));
   alpha = (t - X(k,1))/dt;
   x = (1-alpha).*X(k,2) + alpha.*X(k+1,2);
case 1,
   x = ones(size(t));
case 2,
   x = exp(-t);
case 3,
   x = cos(2*pi*t);
case 4,
   x = sign(sin(2*pi*t));
case 5,
   x = feval(userinput,t);
end
