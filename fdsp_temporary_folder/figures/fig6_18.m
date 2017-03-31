function fig6_18

% FIGURE 6.18: Optimal amplitude response using minimax criterion

clc
clear
fprintf ('Figure 6.18: Optimal amplitude responsee using minimax criterion\n\n')

% Filter specifications

fs = 1;
T = 1/fs;
delta_p = 0.06
delta_s = 0.04
F_p = 0.2*fs;
F_s = 0.3*fs;
m = f_prompt ('Enter filter order m',0,50,12);

% Find equiripple filter

B = abs(F_p-F_s)/fs;
m0 = ceil(-(10*log10(delta_p*delta_s) + 13)/(14.6*B) + 1)
b = f_firparks (m,F_p,F_s,delta_p,delta_s,0,fs);

% Plot amplitude response

N = 250;
[H,f] = f_freqz (b,1,N,fs);
A = abs(H);
A_r = real(H ./ exp(-j*pi*m*f*T));
figure
hold on
plot ([0 F_p],[1 1],'k')
plot ([0 F_p],[1-delta_p 1-delta_p],'k')
plot ([0 F_p],[1+delta_p 1+delta_p],'k')
plot ([F_s F_s],[-delta_s delta_s],'--k')
plot ([F_s fs/2],[delta_s delta_s],'k')
fill ([0 F_p F_p 0],[1-delta_p 1-delta_p 1+delta_p 1+delta_p],'c')
fill ([F_s fs/2 fs/2 F_s],[-delta_s -delta_s delta_s delta_s],'c')
plot ([0 F_p],[1 1],'k')
plot ([0 fs/2],[0 0],'k')
box on
plot (f,A_r,'LineWidth',1.5)
f_labels ('Optimal amplitude response','\it{f/f_s}','\it{A_r(f)}')
f_wait
 