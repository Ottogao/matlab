function fig3_11

% FIGURE 3.11: Computational effort of FFT and DFT

clc
clear
fprintf ('Figure 3.11: Computational effort of FFT and DFT\n\n')

% Compute number of FLOPs

k = 1 : 256;
i = 1 : 8;
N = 2 .^ i;
m = 1.e3;
n_DFT = k .^ 2 / m;
n_FFT = N .* i / (2*m);

% Plot

figure
h = plot (k,n_DFT,N,n_FFT,'o-');
set (h(1),'LineWidth',1.5)
f_labels ('Complex multipications required by DFT and FFT','\it{N}','FLOPs/1000')
legend ('DFT','FFT',2)
f_wait
