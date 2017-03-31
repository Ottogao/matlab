function exam1_12

% EXAMPLE 1.12: Anti-aliasing filter design

clc
clear
fprintf ('Example 1.12: Anti-aliasing filter design\n\n')
F_c = 1;

% Compute minimum filter order

alpha = [2 : 4]
N = [8 : 12]
r = length(N);
n = zeros(r,3);
for i = 1 : r
   for j = 1 : 3
      n(i,j) = ceil(log(2^(2*N(i))-1)/(2*log(alpha(j))));
   end
end
n

% Display results

figure
plot (N,n,'o-','LineWidth',1.5)
f_labels ('Anti-aliasing filter order, {\it\alpha = f_s/(2F_c)}','{\itN} (bits)','{\itn} (filter order)')
text (9.5,5.5,'\alpha = 4')
text (9.5,7.3,'\alpha = 3')
text (9.5,10.3,'\alpha = 2')
f_wait
