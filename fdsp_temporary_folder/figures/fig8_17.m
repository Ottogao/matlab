function fig8_17

% Figure 8.17: A Chebyshev-I lowpass filter 

clc
clear
fprintf ('Figure 8.17: A Chebyshev-I lowpass filter\n\n')

% Filter of order n = 4

F_p = 1
F_s = 1.275
n = 4;
N = 250;
eps = 1/sqrt(10);
delta_p = 1 - 1/sqrt(1+eps^2)
delta_s = 1/sqrt(10)
[b,a] = f_cheby1s(F_p,F_s,delta_p,delta_s,n)
[H,f] = f_freqs (b,a,N,3*F_p);
A_a = abs(H).^2;
figure
plot(f,A_a,'LineWidth',1.5)
f_labels ('Equiripple passband filter','{\itf} (Hz)','\it{A_a^2(f)}')
axis([0,3*F_p,0,1.2])

% Add labels

A1 = 1/(1 + eps^2);
A2 = delta_s^2;
dx = 0.03;
dy = 0.01;
hold on
plot ([F_p F_p],[0,1],'k--')
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
text (-0.35,A1+dy,'1/(1+\epsilon^2)')
plot ([0 F_s],[A2 A2],'k--')
plot ([F_s F_s],[0 A2],'k--')
fill ([F_s 3*F_p 3*F_p F_s],[0 0 A2 A2],'c')
plot (f,A_a)
text (-0.13,A2,'\delta_s^2')
text (F_s-dx,-0.05,'\it{F_s}')
f_wait
