function exam5_13

% EXAMPLE 5.13: FIR scaling to prevent overflow 

clear
clc
fprintf('Example 5.13: FIR scaling to prevent overflow\n\n')
c = 5;
m = 20;
for i = 0 : m
   b(1+i) = 1/(1+i);
end
a = 1;
fs = 1;
p = 250;

% Compute scale factors

s_1 = sum(abs(b))
s_2 = sqrt(sum(b.^2))
[H,f] = f_freqz (b,a,p,fs);
A = abs(H);
s_inf = max(A)
figure 
plot(f,A,'LineWidth',1.5)
f_labels ('FIR magnitude response','\it{f/f_s}','\it{A(f)}')
f_wait
