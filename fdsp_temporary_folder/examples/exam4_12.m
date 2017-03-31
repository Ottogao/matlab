function exam4_12

% EXAMPLE 4.12: Extracting a periodic signal from noise 

clear
clc
fprintf('Example 4.12: Extracting a periodic signal from noise\n')
rand('state',1000)

% Construct signals x and y

N = 256;
k = 0 : N-1;
x = cos(32*pi*k/N) + sin(48*pi*k/N);
a = 0.5;
y = f_randu(1,N,-a,a) + x;
figure
plot (k,y)
f_labels ('A noisy periodic signal','\it{k}','\it{y(k)}')
f_wait

% Compute cross-correlation with periodic pulse train

M = N/8;
L = floor(N/M);
d = zeros(1,N);
for i = 1 : N
   if rem(i-1,M) == 0
      d(i) = 1;
   end
end
c_yd = f_corr (y,d,1,0);

% Plot portions of x and rho

figure
m = 0 : N/4;
plot (m,x(m+1),m,(N/L)*c_yd(m+1))
f_labels ('Comparison of {\itx(k)} and {\it(N/L)c_{y\delta_M}(k)}','\it{k}','signals')
f_wait
