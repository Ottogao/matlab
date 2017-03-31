function exam3_12

% EXAMPLE 3.12: Bartlett's method: white noise 

clear
clc
fprintf('Example 3.12: Bartlett''s method: white noise\n')
rand ('state',1000)

% Generate white noise signal

N = 4096;
a = -5;
b = 5;
x = a + (b-a)*rand(1,N);
L = f_prompt ('Enter length of subsequence',2,N,512);
M = N/L;
P_u = (b^3 - a^3)/(3*(b - a))

% Compute average periodogram

fs = 1;
[S_B,f,P_x] = f_pds (x,N,L,fs,0,0);
sigma2_B = (1/L)*sum((S_B - P_x).^2)
 
% Plot average periodogram

figure
i = 1 : L/2;
hp = plot (i-1,S_B(i),[0 L/2],[P_u,P_u],'k');
set (hp(2),'LineWidth',1.5)
axis ([0,L/2,0,80])
if L < N
   title = sprintf ('Average periodogram: {\\itP_x} = %.3f, {\\it\\sigma^2_B} = %.3f',P_x,sigma2_B);
   f_labels (title,'\it{i}','\it{S_B(i)}')
else
   title = sprintf ('Periodogram: {\\itP_x} = %.3f, {\\it\\sigma^2_N} = %.3f',P_x,sigma2_B);
   f_labels (title,'\it{i}','\it{S_N(i)}')
end
f_wait
