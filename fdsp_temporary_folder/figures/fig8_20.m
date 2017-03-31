function fig8_20

% Figure 8.20: Trapezoid rule integration 

clear
clc
fprintf('Figure 8.20: Trapezoid rule integration\n')
f = inline('1 + f_chebpoly(t/(5.*1.3)-1,3) + t/5','t');

% Compute curve and plot it

m = 100;
tmax = 10;
t = linspace (0,tmax,m);
x_a = f(t);
figure
plot(t,x_a,'LineWidth',1.5)
f_labels ('Trapezoid rule integration','\it{t/T}','\it{x_a(t)}')
hold on
%box off
%axis off
xlim = get(gca,'Xlim');
ylim = get(gca,'Ylim');
plot(xlim,[ylim(1) ylim(1)],'k')
text (xlim(2)-.02,ylim(1),'>')
plot([xlim(1) xlim(1)],ylim,'k')
text (xlim(1)-.005,ylim(2)-.05,'\^')
%text (xlim(2)+.05,ylim(1),'\it{t/T}')
%text (xlim(1)-.05 ,ylim(2)+.15,'\it{x_a(t)}')
T = 1;
kT = [0 : T : tmax];
x = f(kT);
plot(kT,x,'r')

% Add trapezoids

x0 = 3;
x1 = x0+T;
y0 = f(x0);
y1 = f(x1);
xtrap = [x0 x1 x1 x0];
ytrap = [ylim(1) ylim(1) y1 y0];
gray = .05*ones(1,3); 
fill (xtrap,ytrap,'c')
plot (kT,x,'o')
plot ([x0 x0],[ylim(1),y0],'c')
plot ([x1,x1],[ylim(1),y1],'c')
plot ([x0,x1],[y0,y1],'c')
for i = 1 : length(kT)
    plot ([kT(i) kT(i)],[0,f(kT(i))],'--k')
end
f_wait
 