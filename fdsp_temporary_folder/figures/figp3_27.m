function figp3_27

% FIGURE p3.27: Dead-zone nonlinearity (Problem 3.27)

clc
clear
fprintf ('Figure p3.27: Dead-zone nonlinearity\n\n')
 
% Construct dead-zone

a = .4;
b = 1;
x = linspace (-b,b,901);
y = f_deadzone (x,-a,a);
 
% Plot it

figure
plot (x,x,'--',x,y,'LineWidth',1.5)
hold on
plot([-b b],[0 0],'k',[0 0],[-b b],'k')
f_labels ('Dead-zone nonlinearity','\it{x}','\it{y}')
hold on
text (a,-.05,'\it{a}')
text (-a-.07,-.05,'\it{-a}')
f_wait
 