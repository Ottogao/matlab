function fig8_15

% Figure 8.15: Squared magnitude response of a lowpass Butterworth filter 

clc
clear
fprintf ('Figure 8.15: Squared magnitude response of a lowpass Butterworth filter\n\n')

% Plot squared magnitude response

n = 4;
F_c = 1;
delta_p = 1 - sqrt(.9)
delta_s = sqrt(0.1)
A1 = (1 - delta_p)^2;
A2 = delta_s^2;
F_p = F_c*(1/A1 - 1)^(1/(2*n))
F_s = F_c*(1/A2 - 1)^(1/(2*n))
N = 250;
[b,a] = f_butters (F_p,F_s,delta_p,delta_s,n)
[H,f] = f_freqs (b,a,N,3*F_c);
A_a = abs(H).^2;
figure
plot(f,A_a,'LineWidth',1.5)
f_labels('Maximally flat passband filter','{\itf} (Hz)','\it{A_a^2(f)}')
axis([0,3*F_c,0,1.2])

% Add labels

dx = 0.04;
hold on
plot ([F_p F_p],[0,1],'k--')
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
text (-0.28,A1,'(1-\delta_p)^2')
text (F_p-dx,-0.05,'\it{F_p}')
plot ([0 F_s],[A2 A2],'k--')
plot ([F_s F_s],[0 A2],'k--')
fill ([F_s 3*F_c 3*F_c F_s],[0 0 A2 A2],'c')
plot (f,A_a)
text (-0.12,A2,'\delta_s^2')
text (F_s-dx,-0.05,'\it{F_s}')
f_wait
