function exam1_10

% EXAMPLE 1.10: Successive approximation

clc
clear
fprintf ('Example 1.10: Successive approximation\n\n')
n = 8;
V_r = 5;
x_a = f_prompt ('Enter analog input voltage',-V_r,V_r,2.891);

% Compute DAC and comparator outputs

q = 2*V_r/2^n;
b = zeros(1,n);
for i = 1 : n
   j = n+1-i;
   b(j) = 1;
   y_a(i) = f_dac(b,n,V_r);
   if y_a(i) > x_a
      u_a(i) = 0;
      b(j) = 0;
   else
      u_a(i) = 1;
   end
   y_a(i) = f_dac(b,n,V_r);
end

% Interplate for nice plot 

p = 1000;
hwbar = waitbar (0,'Performing interpolated analog to digital conversion');
for i = 1 : p
   waitbar (i/p);
   k(i) = 1 + floor((i-1)*n/p);
   y(i) = y_a(k(i));
   u(i) = u_a(k(i));
   x(i) = x_a;
end
close (hwbar);

% Plot it

figure
subplot(2,1,1)
plot(y,'LineWidth',1.5)
hold on
plot(x,'r--')
xticks = [0 : p/n : p];
yticks = [-V_r : V_r/2 : V_r];
set(gca,'XTick',xticks)
set(gca,'YTick',yticks)
xticklabels = '0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 ';
set(gca,'XTickLabel',xticklabels)
axis([0 p -V_r V_r])
f_labels ('','\it{k}','\it{y_a(k)}')
text (p/20,x_a+.75,'x_a')
subplot(2,1,2)
plot(u,'LineWidth',1.5)
axis ([0 p -1 2])
set(gca,'XTickLabel',xticklabels)
yticks = [-1 : 1 : 2];
set(gca,'YTick',yticks)
axis([0 p -1 2])
f_labels ('','\it{k}','\it{u_a(k)}')
f_wait
 