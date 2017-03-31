function [h,k] = f_impulse (b,a,N,bits,realize,graph,caption,fsize)

%F_IMPULSE: Compute impulse response of a discrete-time system
%
% Usage: [h,k] = f_impulse (b,a,N,bits,realize,graph,caption,fsize)
%
% Inputs: 
%         b       = 1 by m+1 vector containing coefficients 
%                   of numerator polynomial
%         a       = 1 by n+1 vector containing coefficients 
%                   of denominator polynomial
%         N       = number of samples
%         bits    = optional integer specifyiing the number
%                   of fixed-point bits used for coefficient 
%                   quantization. Default: double precision 
%                   floating-point   
%         realize = optional integer specifying the 
%                   realization structure to use.  Default: 
%                   the direct form of MATLAB function filter.   
%
%                   0 = direct form
%                   1 = cascade form
%                   2 = lattice form (FIR) or parallel 
%                       form (IIR)
%
%         graph   = plot the impulse response if graph <> = 0
%         caption = plot title
%         fsize   = optional font size         
% Outputs: 
%          h = N by 1 vector containing samples of impulse 
%              response
%          k = N by 1 vector containing discrete times 
%              0 : r-1
%
% Note: For the parallel form, the poles of H(z) must be 
%       distinct
%
% See also: F_FILTER, F_FILTCAS, F_FILTPAR, F_FILTLAT

% Initialize

N = f_clip (N,1,N);
delta = [1 ; zeros(N-1,1)];
if nargin < 8
    fsize = 10;
end
   
% Compute zero-state output   

k = [0 : N-1]';
if (nargin < 4)
    h = f_filter (b,a,delta);
elseif (nargin < 5)
    h = f_filter (b,a,delta,bits);
else
    h = f_filter (b,a,delta,bits,realize);
end

% Plot impulse response

if (nargin > 5) & graph
    
   kmax = min(100,N);
   m = length(b)-1;
   if length(a) < 2
        kmax = m;
   end
   k = [0 : kmax];
   stem (k,real(h(k+1)),'filled','.')
   axis square
   f_labels (caption,'k','h(k)','',fsize)
   ymax = max(abs(get(gca,'Ylim')));
   axis([-10,kmax+10,-ymax,ymax])

end  
