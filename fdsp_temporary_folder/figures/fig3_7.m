function fig3_7

% FIGURE 3.7:  The mod function

clc
clear
fprintf ('Figure 3.7: The mod function\n\n')

% Construct r(k) = mod(k,N) and plot it

N = 8;
k = -N : 2*N;
r = mod(k,N);
figure
hp = stem (k,r,'filled','.');
set (hp,'LineWidth',1.5)
f_labels ('The mod function','\it{k}','mod({\itk},8)')
hold on
plot ([-N 2*N],[0 0],'k',[-N 2*N],[N N],'--k')
axis ([-N 2*N -2 10])
f_wait
 