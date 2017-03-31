function exam6_8

% EXAMPLE 6.8:  Equiripple FIR bandpass filter

clc
clear
fprintf ('Example 6.8: Equiripple FIR bandpass filter\n')

% Filter specifications

delta_p = 0.02
delta_s = 0.02
ftype = 2;
fs = 1;
T = 1/fs;
F_p = [.2 .3]*fs;
F_s = [.18 .32]*fs;

% Compute equiripple filter

B = abs(F_s(1)-F_p(1))/fs;
m0 = ceil(-(10*log10(delta_p*delta_s) + 13)/(14.6*B) + 1)
m = f_prompt ('Enter filter order',0,120,84);
b = f_firparks (m,F_p,F_s,delta_p,delta_s,ftype,fs);

% Plot amplitude response

N = 250;
[H,f] = f_freqz (b,1,N,fs);
A = abs(H);
figure
hold on
fill ([0 F_s(1) F_s(1) 0],[0 0 delta_s delta_s],'c')
fill ([F_p(1) F_p(2) F_p(2) F_p(1)],[1-delta_p 1-delta_p 1+delta_p 1+delta_p],'c')
fill ([F_s(2) fs/2 fs/2 F_s(2)],[0 0 delta_s delta_s],'c')
plot (f,A,'LineWidth',1.5)
axis ([0 0.5 0 1.2])
box on
f_labels ('Equiripple filter','\it{f/f_s}','\it{A(f)}')
f_wait

figure
A = 20*log10(A);
A_p = -20*log10(1 - delta_p)
A_s = -20*log10(delta_s)
hold on
c = -50;
axis([0 0.5 c 5])
fill ([0 F_s(1) F_s(1) 0],[c c -A_s -A_s],'c')
fill ([F_p(1) F_p(2) F_p(2) F_p(1)],[-A_p -A_p A_p A_p],'c')
fill ([F_s(2) fs/2 fs/2 F_s(2)],[c c -A_s -A_s],'c')
plot (f,A,'LineWidth',1.5)
box on
f_labels ('Equiripple filter','\it{f/f_s}','{\itA(f)} (dB)')
f_wait
 