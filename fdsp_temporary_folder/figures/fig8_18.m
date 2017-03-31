function fig8_18

% Figure 8.18: A Chebyshev-II lowpass filter 

clc
clear
fprintf ('Figure 8.18: A Chebyshev-II lowpass filters\n\n')

% Filter of order n = 4

F_s = 1
F_p = 0.78
n = 4;
N = 250;
eps = 1/sqrt(10);
delta_p = 1 - sqrt(.9)
delta_s = sqrt(eps^2/(1 + eps^2))
[b,a] = f_cheby2s(F_p,F_s,delta_p,delta_s,n)
[H,f] = f_freqs (b,a,N,3*F_p);
A_a = abs(H).^2;
figure
plot(f,A_a,'LineWidth',1.5)
f_labels ('Equiripple stopband filter','{\itf} (Hz)','\it{A_a^2(f)}')
axis([0,3*F_p,0,1.2])

% Add labels

delta_s = eps/sqrt(1 + eps^2);
A1 = 1/(1 + eps^2);
A2 = delta_s^2;
dx = 0.03;
dy = 0.01;
hold on
plot ([0 F_p],[1 1],'k')
plot ([F_p F_p],[0,1],'k--')
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
text (-0.28,A1+dy,'(1 - \delta_p)^2')
plot ([0 F_s],[A2 A2],'k--')
fill ([F_s 3*F_s 3*F_s F_s],[0 0 A2 A2],'c')
plot (f,A_a)
text (-0.31,A2,'\epsilon^2/(1+\epsilon^2)')
text (F_p-dx,-0.05,'\it{F_p}')
f_wait
