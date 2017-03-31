function exam2_28

% EXAMPLE 2.28: Home mortgage 

clear
clc
fprintf('Example 2.28: Home mortgage\n') 
n = 31;
b = linspace(0,300,n)';        % size of mortgage
d = [15 20 30];                % duration in years
p = zeros(n,3);                % monthly payments

% Compute monthly payments

r = f_prompt('Enter interest rate in percent:',0,20,7.5)/100;
a = 1 + r/12;
c = a.^(12*d+1);
for k = 1 : n
   for j = 1 : length(d)
      p(k,j) = 1000*b(k)*c(j)*(a-1)/(c(j)-1);
   end
end
figure
plot(b,p,'LineWidth',1.5)
f_labels ('Monthly mortgage payments','Size of mortgage ($1000)',...
          'Monthly payment ($)')
hold on
for j = 1 : length(d)
   duration = sprintf ('%d year',d(j));
   text (b(n)+3,p(n,j),duration)
end
f_wait
      
% Compute balance vs time

q = 12*d(3)+1;                    % number of months                          
k = [0 : q-1]';                   % discrete times
y0 = b(21)*a.^(k+1);              % zero-input response
num = [-1 0];                     % numerator coefficients
den = [1 -a];                     % denominator coefficients
x = p(21,3)*ones(q,1);            % step of amplitude p
y1 = filter(num,den,x)/1000;      % zero-state response 
y(:,1) = y0 + y1;             
y(:,2) = (6*p(21,3)/(1000*r))*ones(q,1);
figure
h = plot (k,y(:,1),k,y(:,2));
set (h(1),'LineWidth',1.5)
f_labels ('Balance due on 30 year $200,000 mortgage','Month','Balance ($1000)')

% Find crossover month

text (k(q)+5,y(q,2),'6\it{p/r}')
crossover = min(find(y(:,1) < y(:,2)))
hold on
plot ([k(crossover),k(crossover)],[0,y(crossover,2)],'r--')
plot (k(crossover),y(crossover),'.')
axis ([0 400 0 200])
f_wait
  