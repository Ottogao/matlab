function exam2_29

% EXAMPLE 2.29: Satellite attitude control 

clear
clc
fprintf('Example 2.29: Satellite attitude control\n')
n = 21;
T = .1;                             % sampling interval
J = 5;                              % moment of inertia
c = [.1 3-sqrt(8) .5]*(2*J/T^2)     % controller gains
d = (T^2/(2*J))*c;
m = length(c);

% Compute step response

r = (pi/2)*ones(n,1);
for i = 1 : m
   a = [1 d(i)-1 d(i)];
   b = [0 d(i) d(i)];
   pole = roots(a)
   y(:,i) = (180/pi)*filter(b,a,r);
end

% Plot curves

figure
k = [0 : n-1];
for i = 1 : 3
    subplot (3,1,i)
    hp = stem (k,y(:,i),'filled','.');
    set (hp,'LineWidth',1.5)
    axis ([k(1) k(n) 0 150])
    switch i
    case 1,
        title ('Satellite step response')
        text (10,120,'Overdamped','HorizontalAlignment','center')
    case 2,
        ylabel ('{\ity(k)} (deg)')
        text (10,120,'Critically damped','HorizontalAlignment','center')
    case 3,
        xlabel ('\it{k}')
        text (10,120,'Underdamped','HorizontalAlignment','center')
    end
    hold on
    plot(k,(180/pi)*r,'r')
end
f_wait
 