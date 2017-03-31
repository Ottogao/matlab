function f_pzplot (b,a,caption,fsize)

%F_PZPLOT: Plot transfer function poles and zeros
%
%          H(z) = b(z)/a(z)
%
% Usage: f_pzplot (b,a,caption,fsize);
%
% Inputs: 
%         b       = numerator coefficient vector 
%         a       = denominator coefficient vector 
%         caption = optional plot title
%         fsize   = optional font size
%
% See also: F_PZSURF

if nargin < 4
    fsize = 10;
end

% Find poles and zeros

pole = roots(a);   
zero = roots(b);
r = length(zero) - length(pole);

if r > 0
   pole = [pole ; zeros(r,1)];
elseif r < 0
   zero = [zero ; zeros(-r,1)];
end
np = length(pole);
nz = length(zero);

% Look for pole-zero cancellation

cancel = 1;
while cancel == 1
   cancel = 0;
   for i = 1 : np
      for j = 1 : nz
         dist = abs(zero(j)-pole(i));
         if dist < 1.e-6
            cancel = 1;
            pole = [pole(1:i-1) ; pole(i+1:np)];
            np = length(pole);
            zero = [zero(1:j-1) ; zero(j+1:nz)];
            nz = length(zero);
            break;
         end
      end
      if cancel == 1
         break
      end
   end
end

% Plot poles and zeros

xsize = 9;
phi = linspace(0,2*pi,361);
x0 = cos(phi);
y0 = sin(phi);
hold off
box off
hp = plot(x0,y0,[-2 2],[0 0],'k',[0 0],[-2 2],'k');
set (hp(1),'LineWidth',1.5)
axis square
hold on
for i = 1 : np
   plot(real(pole(i)),imag(pole(i)),'rx','MarkerSize',xsize)
end
for i = 1 : nz
   plot(real(zero(i)),imag(zero(i)),'ro')
end
xmax = max(abs(get(gca,'Xlim')));
ymax = max(abs(get(gca,'Ylim')));
range = max(xmax,ymax);
axis([-range range -range range])
plot([-range range],[0 0],'k',[0 0],[-range range],'k')

% Labels

f_labels ('','Re(\it{z})','Im(\it{z})','',fsize)
if (nargin < 3) | (isempty(caption))
   f_labels ('Pole-zero plot','Re(\it{z})','Im(\it{z})','',fsize)
else
   f_labels (caption,'Re(\it{z})','Im(\it{z})','',fsize)
end
