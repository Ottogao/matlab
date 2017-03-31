function fig4_19

% FIGURE 4.19: Auto-correlation of white noise 

clear
clc
fprintf('Figure 4.19: Auto-correlation of white noise\n\n')

% Compute signal and its normalized  auto-correlation

L = 1024;
v = f_randg(1,L,0,1);
rho_vv = f_corr (v,v,0,1);

% Plot normalized cross-correlation

figure
plot (0:L-1,rho_vv)
f_labels ('Normalized auto-correlation of white noise','\it{k}','\it{\rho_{vv}(k)}')
axis ([-100,1100,-.2 1.2])
f_wait
