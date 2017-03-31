function exam4_8

% EXAMPLE 4.8:  Linear cross-correlation 
%--------------------------------------------------------------------------------

clear
clc
fprintf('Example 4.8: Linear cross-correlation\n')

% Compute and plot signals

L = 10;
M = 5;
x = [4 -1 -2 0 4 2 4 0 -2 2]';
y = [0 2 1 2 0]';
figure 
h = plot (0:L-1,x,'o-',0:M-1,y,'s-');
set (h(2),'LineWidth',1.5)
axis ([0 9 -3 5])
legend ('\it{x}','\it{y}')
f_labels ('Two discrete-time signals','\it{k}','signals')
f_wait

% Compute and plot cross-correlation

r_xy = f_corr (x,y,0,0)
figure
plot (0:L-1,r_xy,'o-','LineWidth',1.5);
hold on
[rmax,imax] = max(r_xy);
plot ([imax-1 imax-1],[0 rmax],'k--',[0 L-1],[0 0],'k')
f_labels ('Linear cross-correlation','\it{i}','\it{r_{xy}(i)}')
f_wait

% Compute and plot normalized cross-correlation

rho_xy = f_corr (x,y,0,1)
figure
plot (0:L-1,rho_xy,'o-','LineWidth',1.5)
hold on
[rmax,imax] = max(rho_xy);
plot ([imax-1 imax-1],[0 rmax],'k--',[0 L-1],[0 0],'k',[0 L-1],[1 1],'k--')
f_labels ('Normalized linear cross-correlation','\it{i}','\it{\rho_{xy}(i)}')
f_wait
