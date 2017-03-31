function fig4_4

% FIGURE 4.4:  Signal received at radar station

clear
clc
rand ('state',1000)
fprintf('Figure 4.4: Signal received at radar station\n\n')

% Compute and plot received signal

M = 512;
b = 1;
y = f_randu(1,M,-b,b);
N = 2048;
mu = 0;
sigma = .05;
x = f_randg (1,N,mu,sigma);
m = 938;
alpha = 0.05;
for i = 1 : M
   x(m+i) = x(m+i) + alpha*y(i);
end
figure
k = 1 : N;
plot (k-1,x)
axis ([0 N -.5 .5])
f_labels ('Received signal','\it{k}','\it{x(k)}')
f_wait

% Compute normalized cross-correlation of x with y

figure
circ = 0;
norm = 1;
rho_xy = f_corr (x,y,circ,norm);
plot (0:N-1,rho_xy)
axis ([0 N -.1 .3])
f_labels ('Normalized cross-correlation','\it{k}','\it{\rho_{xy}(k)}')
[rmax,m] = max(rho_xy)
f_wait
