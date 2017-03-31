function f_pzsurf (b,a,hmax,N,circle,fsize,dB)

%F_PZSURF: Surface plot of transfer function magnitude
%
%          H(z) = b(z)/a(z)
%
% Usage: f_pzsurf (b,a,hmax,N,circle,fsize,dB);
%
% Inputs: 
%         b      = vector containing numerator coefficients
%         a      = vector containing denominator coefficients
%         hmax   = clip level, plot min(|H(z)|,c)
%         N      = number of plot points in each dimension
%         circle = if present and nonzero, draw a black
%                  unit circle at elevation z = 0.
%         fsize  = optional font size
%         dB     = optional decibel switch (nonzero = dB)        
%
% See also: F_PZPLOT

if nargin < 6
    fsize = 10;
end
if nargin < 7
    dB = 0;
end
hmin = -80;

% Convert coefficients to positive powers of z for polyval

m = length(b);
n = length(a);
if (m <= n)
    b = [f_torow(b) , zeros(1,n-m)];
else
    a = [f_torow(a) , zeros(1,m-n)];
end

% Compute A = |H(z)|

warning off 
d = 2.0;
A = zeros(N,N);
zr = linspace (-d,d,N);
zi = zr;
for i = 1 : N
   for k = 1 : N
      z = zr(k) + j*zi(i);
      A(i,k) = min(abs(polyval(b,z)/polyval(a,z)),hmax);
      if dB
          A(i,k) = max(20*log10(A(i,k)),hmin);
      end
   end
end
warning on 

% Plot it

mver = f_version('MATLAB');
surfc (zi,zr,A,'EraseMode','normal');
if mver < 7.0
   pause(0.01)                    % fix for Windows XP?
   surfc (zi,zr,A,'EraseMode','normal');
end
if dB
   f_labels ('Magnitude of transfer function','Re(\it{z})','Im(\it{z})','|{\itH(z)}| (dB)',fsize)
else    
   f_labels ('Magnitude of transfer function','Re(\it{z})','Im(\it{z})','|{\itH(z)}|',fsize)
end

% Add unit circle

if (nargin > 4) & ~isempty(circle)
   hold on
   q = 2*N;
   r = 1;
   phi = linspace (0,2*pi,q);
   x = r*cos(phi);
   y = r*sin(phi);
   z = zeros(1,q);
   plot3 (x,y,z,'k','LineWidth',1.0)
end
