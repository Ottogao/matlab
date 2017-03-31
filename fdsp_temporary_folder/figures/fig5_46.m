function fig5_46

% FIGURE 5.46: Stable pole locations of a quantized second-order block

clc
clear
fprintf ('Figure 5.46: Stable pole locations of a quantized second-order block\n\n')
c = 2;
N = 5;
q = c/2^(N-1)
a_1 = [-c+q : q : c-q];
a_2 = [0 : q : 1];

% Pole locations

sigma = a_1/2;
r = sqrt(abs(a_2));

% Draw unit circle

figure
b = 1.0;
c = 1.2
plot([-c,c],[0 0],'k')
f_labels ('Stable quantized pole locations','Re({\itz})','Im({\itz})')
axis ([-c c 0 b])
hold on

% Draw quantization lines

m = 101;
phi = linspace (0,pi,181);
for i = 1 : length(r)
   x = r(i)*cos(phi);
   y = r(i)*sin(phi);
   plot (x,y,'y');
end

% Draw pole locations

for i = 1 : length(sigma)
   x0 = sigma(i);
   for k = 1 : length(r)
      if (r(k) < 1) & (r(k) >= abs(x0))
         y0 = sqrt(r(k)^2 - x0^2);
         plot (x0,y0,'rx')
      end
   end
end

% Add unit circle

phi = linspace(0,pi,181);
x = cos(phi);
y = sin(phi);
plot(x,y,'b','LineWidth',1.5)
axis equal
f_wait

 