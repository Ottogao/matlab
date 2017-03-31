function fig6_3

% FIGURE 6.3:  Second-order backward differentiator 

clear
clc
fprintf('Figure 6.3: Second-order backward differentiator\n\n')

% Construct input

fs = 20;
T = 1/fs;
p = 80;
k = [0 : p-1];
t = k*T;
x = sin(pi*t);
rand('seed',1000)

% Compute response

b = [3 -4 1]/(2*T);
a = 1;
y_2 = filter (b,a,x);
xdot = pi*cos(pi*t);

% Plot results

figure
hp = plot (t,x,t,xdot,t,y_2,'.');
set (hp(1),'LineWidth',1.5)
set (hp(3),'LineWidth',1.5)
f_labels('Second-order differentiator','t (sec)','Signals')
text (0.9,0.5,'\it{x_a}')
text (0.12,4.65,'\it{y_2}')
text (1.3,-2.5,'\it{x_a}')
text (1.315,-2.16,'.')
legend ('Input','Derivative','Estimated derivative')
f_wait

% Add noise

d = 0.01;
w = x + f_randu(1,p,-d,d);
P_x = 1/sqrt(2)
P_v = 2*(d^3 - (-d)^3)/(3*(d - (-d)))
SNR = P_x/P_v
y = filter (b,a,w);
figure
hp = plot (t,w,t,xdot,t,y,'.');
set (hp(1),'LineWidth',1.5)
set (hp(3),'LineWidth',1.5)
f_labels('Second-order differentiator','t (sec)','Signals')
text (0.9,0.5,'\it{x_a}')
text (0.12,4.35,'{\ity_2}')
text (1.35,-1.9,'\it{x_a}')
text (1.365,-1.56,'.')
legend ('Noisy input','Derivative','Estimated derivative')
f_wait
