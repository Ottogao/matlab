function fig8_21

% Figure 8.21: Bilinear transformation from s plane to z plane 

clear
clc
fprintf('Figure 8.21: Bilinear transformation from s plane to z plane\n\n')
 
% Plot s plane
 
figure
subplot(1,2,1)
box off
x = [-2 0 0 -2];
y = [-2 -2 2 2];
fill (x,y,'c')
hold on
plot([-2 2],[0 0],'k',[0 0],[-2 2],'b--')
axis square
hold on
f_labels ('Analog s plane','Re({\its})','\pi{\itT }Im({\its})')
text (-.05,1,'\^')
plot (0,0,'s')

% Plot z plane

r = 1;
phi = linspace(0,2*pi,361);
x = r*cos(phi);
y = r*sin(phi);
subplot(1,2,2)
box off
fill (x,y,'c')
hold on
plot(x,y,'b--',[-2 2],[0 0],'k',[0 0],[-2 2],'k')
axis square
hold on
f_labels ('Digital z plane','Re({\itz})','Im({\itz})')
text(0,1,'<')
plot(1,0,'s')
f_wait
