function exam9_18

% Example 9.18: Constant interpolation property of raised-cosine RBFs 

clear
clc
fprintf('Example 9.18: Constant interpolation property of raised-cosine RBFs\n\n')
a = [-1,1];
b = [-1,1];
d = 2;
m = 0;
n = 1;
p = m+n+1;
N = 61;
g = zeros(N,N);
r = d^p;

% Compute RBF

x = 4*linspace(a(1),a(2),N);
y = 4*linspace(b(1),b(2),N);
h = waitbar (0,'Computing RBF surface');
for i = 1 : N
    waitbar (i/N,h)
    for j = 1 : N
       theta = [x(i) ; y(j)];
       for k = 0 : r-1
           phi = f_gridpoint (k,a,b,m,n,d);
           g(j,i) = g(j,i) + f_rbfg (theta-phi,a,b,m,n,d);
       end
   end
end
close(h);

% Plot it

figure
mesh (x,y,g,'EraseMode','normal')
pause (0.01)
mesh (x,y,g,'EraseMode','normal')
%set (gca,'CLim',[0.9999 1])
f_labels ('Raised-cosine RBF network','\theta_1','\theta_2','{\itf_0}(\theta)')

% Show grid points

hold on
for i = -1 : 2 : 1
    for j = -1 : 2 : 1
        plot3 (i,j,1,'k.')
    end
end
f_wait
