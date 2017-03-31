function exam2_30

% EXAMPLE 2.30: The Fibonacci sequence and the golden ratio 

clear
clc
fprintf('Example 2.10.3: The Fibonacci Sequence and the Golden Ratio\n')
N = 21;
gamma = (1 + sqrt(5))/2;      % golden ratio
g = zeros(N,1);               % estimates of gamma
a = [1 -1 -1];                % denominator coefficients       
b = 1;                        % numerator coefficients 

% Estimate golden ratio with pulse response

[h,k] = f_impulse (b,a,N);
h
for i = 2 : N
   g(i) = h(i)/h(i-1);
end
figure
hp = stem (k(2:N),g(2:N),'filled','.');
set (hp,'LineWidth',1.5)
f_labels ('The golden ratio','\it{k}','\it{h(k)/h(k-1)}')
axis ([k(1) k(N) 0 3])
hold on
plot (k,gamma*ones(N),'r')
golden = sprintf ('\\gamma = %.6f',gamma);
text (10,2.4,golden,'HorizontalAlignment','center')
f_wait
 