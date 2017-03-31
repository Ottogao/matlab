function exam4_10

% EXAMPLE 4.10: Power density spectrum 

clear
clc
fprintf('Example 4.10: Power density spectrum\n')

% Construct and plot x(k)

N = 512;
M = 4;
x = zeros(1,N);
for i = 1 : N
   if (i >= N/2-M) & (i < N/2)
      x(i) = 1;
   elseif (i >= N/2) & (i < N/2+M)
      x(i) = -1;
   end
end

% Compute the power density spectrum using auto-correlation

c = f_corr (x,x,1,0);
fs = 20;
S_N = real(fft(c));
X = fft(x,N);
R = abs(X).^2/N;
i = 0 : N/2;

% Plot the results

figure
k = 0 : N-1;
subplot(2,1,1)
plot (k,x,'LineWidth',1.5)
axis ([0 N-1 -1.5 1.5])
f_labels ('A double pulse','\it{k}','\it{x(k)}')
subplot(2,1,2)
plot (i,S_N(i+1),i,R(i+1),'LineWidth',1.5)
f_labels ('Power density spectrum','\it{i}','\it{S_N(i)}')
f_wait
