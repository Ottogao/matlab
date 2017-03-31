function fig4_16

% FIGURE 4.16: Computational effort for fast linear cross-Ccrrelation 

clear
clc
fprintf('Figure 4.16: Computational effort for fast linear cross-correlation\n\n')

% Compute curves

m = 11;
L = 2 : 2^m;
n_dir = L.^2/2 + 1;
i = 2 : m;
k = 2.^i;
n_fast = 12*k.*log(2*k)/log(2) + 8*k + 4;

% Plot them

figure
h = plot (L,n_dir/1000,k,n_fast/1000,'-o');
set (h(1),'LineWidth',1.5)
legend ('Direct','Fast')
f_labels ('Computational effort for linear cross-correlation','\it{L}','FLOPs/1000')
f_wait
