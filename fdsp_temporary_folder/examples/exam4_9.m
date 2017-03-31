function exam4_9

% EXAMPLE 4.9:  Fast linear correlation 

clear
clc
fprintf('Example 4.9: Fast linear correlation\n')
rand('state',2000)

% Construct signals x and y

L = 1024;
M = 512;
k = 0 : L-1;
i = 0 : M-1;
y = 3*(i/M) .* exp(-4*i/M) .* sin(5*pi*i.^2/M);
x = f_randu(1,L,-1,1);
p = 279;
x(p:p+M-1) = x(p:p+M-1) + y;

% Plot x and y

figure
plot(k,x,i,y+2)
f_labels ('A pair of signals','\it{k}','signals')
text (L+20,0,'\it{x}')
text (M+20,2,'\it{y}+2')
f_wait

% Compute and plot normalized cross correlation usign fast correlation

rho = f_corr(x,y,0,1);
figure
plot (k,rho)
f_labels ('Normalized cross-correlation','\it{k}','\it{\rho_{xy}(k)}')

% Compute peak and number of FLOPs

[rhomax,m] = max(rho);
fprintf ('\nr(%i) = %.3f\n',m,rho(m))
n_fast = 12*L*log(2*L) + 8*L + 6
n_direct = L^2/2 + 1
f_wait
