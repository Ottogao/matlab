function figp3_26

% FIGURE p3.26: Periodic pulse train (Problem 3.26)

clc
clear
fprintf ('Figure p3.26: Periodic pulse train\n\n')
 
% Construct pulse train

T = 1;
a = 10;
tau = T/5;
n = 800;
t = linspace (0,2*T,n);
x = zeros(1,n);
for i = 1 : n
   if (t(i) <= tau) | ((t(i) >= T) & (t(i) <= tau+T)) 
      x(i) = a;
   end
end

% Plot it

figure
plot ([0 2*T],[0 0],'k')
hold on
plot (t,x,'LineWidth',1.5)
axis ([0 2*T 0 15])
f_labels ('Pulse train','\it{t}','\it{x(t)}')
f_wait
 