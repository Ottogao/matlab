function figp3_14

% FIGURE p3.14: Probabilty density function (Problem 3.14)

clc
clear
fprintf ('Figure p3.14: Probabilty density function\n\n')
 
% Construct function

n = 201;
x = linspace (-2,2,n);
p = zeros(1,n);
for i = 1 : n
   if (x(i) >= -1) & (x(i) <= 0)
      p(i) = 1 + x(i);
   end
   if (x(i) > 0) & (x(i) <= 1)
      p(i) = 1 - x(i);
   end
end

% Plot it

figure
plot ([-2 2],[0 0],'k',[0 0],[-.5 2],'k')
hold on
plot (x,p,'LineWidth',1.5)
f_labels ('Probability density function','\it{x}','\it{p(x)}')
f_wait
 