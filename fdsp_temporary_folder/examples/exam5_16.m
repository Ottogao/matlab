function exam5_16

% EXAMPLE 5.16: Limit cycle due to roundoff error 

clear
clc
fprintf('Example 5.16: Limit cycle due to roundoff error\n')
b_0 = 3;
a_1 = 0.7;
N = 4;
c = 4;
q = c/2^(N-1);
p = 31;

% Find quantized impulse response

y = zeros(1,p);
for i = 1 : p
   if (i == 1)
      y(1) = b_0;
   else
      y(i) = f_quant(-a_1*y(i-1),q,0);
   end
end

% Normal pulse response

x = [1,zeros(1,p-1)];
h = filter (b_0,[1,a_1],x);

% Plot it

k = 0 : p-1;
figure
plot(k,h,'r','LineWidth',1.5)
hold on
hp = stem (k,y,'filled','.');
set (hp(1),'LineWidth',1.5)
f_labels ('Impulse response','\it{k}','\it{h_q(k)}')
axis ([0 p-1 -3 3])
legend ('Unquantized','Quantized')
f_wait
