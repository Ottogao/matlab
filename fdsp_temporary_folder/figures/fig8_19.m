function fig8_19

% Figure 8.19: An elliptic lowpass filter 

clc
clear
fprintf ('Figure 8.19: An elliptic lowpass filters\n\n')

% Filter of order n = 4

F_p = 1;
F_s = 1.035;
n = 4;
N = 250;
c = 1.2;
delta_p = 1 - sqrt(.9)
eps = sqrt((1-delta_p)^(-2)-1);
delta_s = sqrt(0.1)
[b,a] = f_elliptics (F_p,F_s,delta_p,delta_s,n)
[H,f] = f_freqs (b,a,N,3*F_p);
A = abs(H) .^ 2;
figure
plot (f,A,'LineWidth',1.5)
axis ([0 3*F_p 0 c])
f_labels ('Equiripple filter','{\itf} (Hz)','\it{A_a^2(f)}')

% Add labels

A1 = 0.9;
A2 = 0.1;
dx = 0.01;
dy = 0.01;
hold on
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
plot ([F_p F_p],[0,1],'k--')
text (-0.34,A1+dy,'(1 - \delta_p)^2')
plot ([0 F_s],[A2 A2],'k--')
fill ([F_s 3*F_s 3*F_s F_s],[0 0 A2 A2],'c')
plot (f,A)
text (-0.15,A2,'\delta_s^2')
text (F_s-dx,-0.05,'\it{F_s}')
f_wait
