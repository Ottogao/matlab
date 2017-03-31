function fig4_9

% FIGURE 4.9:  Computational effort for fast convolution 

clear
clc
fprintf('Figure 4.9: Computational effort for fast convolution\n\n')

% Compute curves

m = 10;
L = 2 : 2^m;
n_dir = 2*L.^2;
i = 2 : m;
k = 2.^i;
n_fast = 12*k.*log(2*k)/log(2) + 8*k + 4
n32 = 2*32^2/1.e5
n64 = 2*64^2/1.e6

% Plot them

figure
h = plot (L,n_dir/1000,k,n_fast/1000,'-o');
set (h(1),'LineWidth',1.5)
f_labels ('Computational effort for linear convolution','\it{L}','FLOPs/1000')
legend ('Direct','Fast')
f_wait
