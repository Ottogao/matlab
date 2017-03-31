function exam9_17

% Example 9.17: Raised-cosine radial basis function 

clear
clc
fprintf('Example 9.17: Raised-cosine radial basis function\n\n')
a = [-4,4];
b = [-2,2];
d = 3;
m = 0;
n = 1;
p = m+n+1;
N = 51;
g = zeros(N,N);

% Compute RBF

x = 1.5*linspace(a(1),a(2),N);
y = 1.5*linspace(b(1),b(2),N);
h = waitbar (0,'Computing RBF');
for i = 1 : N
    waitbar (i/N,h)
    for j = 1 : N
       theta = [x(i) ; y(j)]; 
       g(j,i) = f_rbfg (theta,a,b,m,n,d);
   end
end
close(h);

% Plot it

figure
mesh (x,y,g,'EraseMode','normal')
pause (0.01)
mesh (x,y,g,'EraseMode','normal')
%set (gca,'CLim',[0.99 1])
axis([-6 6 -3 3 0 1])
f_labels ('Raised-cosine RBF','\theta_1','\theta_2','{\itG}(\theta)')

% Show grid points

hold on
plot3 (-4,-2,0,'k.')
plot3 (-4,2,0,'k.')
plot3 (4,-2,0,'k.')
plot3 (0,0,1,'k.')
f_wait
