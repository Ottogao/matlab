function exam6_11

% EXAMPLE 6.11: FIR bandstop filter design

clc
clear
fprintf ('Example 6.11: FIR bandstop filter design\n\n')
delta_p = 0.04
delta_s = 0.02
A_p = -20*log10(1 - delta_p)
A_s = -20*log10(delta_s)
fs = 2000;
T = 1/fs;
F_p = [200 800]
F_s = [300 700]
a = 1;
N = 250;
sym = 0;
A_min = 80;
A_max = 20;
m = f_prompt ('Enter filter order',0,120,80);

% Compute windowed filter 

win = f_prompt ('Enter window type',0,3,3);
p = [F_p(1), F_s(1), F_s(2), F_p(2)];
b = f_firwin (@bandstop,m,fs,win,sym,p);
[H,f] = f_freqz (b,a,N,fs);
AdB = 20*log10(abs(H));
i_stop = (f >= F_s(1)) & (f <= F_s(2));
A_stop = -max(AdB(i_stop))
figure
caption = sprintf ('Windowed filter, {\\itm} = %d, {\\itA_s} = %.1f dB',m,A_stop);
f_labels (caption,'{\itf} (Hz)','{\itA(f)} (dB)')
axis ([0 fs/2 -A_min A_max])
hold on
box on
fill ([0 F_p(1) F_p(1) 0],[-A_p -A_p A_p A_p],'c')
fill ([F_s(1) F_s(2) F_s(2) F_s(1)],[-A_min -A_min -A_s -A_s],'c')
fill ([F_p(2) fs/2 fs/2 F_p(2)],[-A_p -A_p A_p A_p],'c')
plot (f,AdB,'LineWidth',1.5)
f_wait

% Compute frequency-sampled filter 

M = floor(m/2) + 1;
F = linspace (0,fs/2,M);
A = bandstop (F,fs,p);
b = f_firsamp (A,m,fs,sym);
[H,f] = f_freqz (b,a,N,fs);
AdB = 20*log10(abs(H));
figure
A_stop = -max(AdB(i_stop))
caption = sprintf ('Frequency-sampled filter, {\\itm} = %d, {\\itA_s} = %.1f dB',m,A_stop);
f_labels (caption,'{\itf} (Hz)','{\itA(f)} (dB)')
axis ([0 fs/2 -A_min A_max])
hold on
box on
fill ([0 F_p(1) F_p(1) 0],[-A_p -A_p A_p A_p],'c')
fill ([F_s(1) F_s(2) F_s(2) F_s(1)],[-A_min -A_min -A_s -A_s],'c')
fill ([F_p(2) fs/2 fs/2 F_p(2)],[-A_p -A_p A_p A_p],'c')
plot (f,AdB,'LineWidth',1.5)
f_wait

% Compute least-squares filter 

F = linspace (0,fs/2,m);
A = bandstop (F,fs,p);
w = delta_s/delta_p;
W = w*ones(size(A));
W(i_stop) = 1;
b = f_firls (F,A,m,fs,W);
[H,f] = f_freqz (b,a,N,fs);
AdB = 20*log10(abs(H));
figure
A_stop = -max(AdB(i_stop))
caption = sprintf ('Least-squares filter, {\\itm} = %d, {\\itA_s} = %.1f dB',m,A_stop);
f_labels (caption,'{\itf} (Hz)','{\itA(f)} (dB)')
axis ([0 fs/2 -A_min A_max])
hold on
box on
fill ([0 F_p(1) F_p(1) 0],[-A_p -A_p A_p A_p],'c')
fill ([F_s(1) F_s(2) F_s(2) F_s(1)],[-A_min -A_min -A_s -A_s],'c')
fill ([F_p(2) fs/2 fs/2 F_p(2)],[-A_p -A_p A_p A_p],'c')
plot (f,AdB,'LineWidth',1.5)
f_wait
 
% Compute equiripple filter 

ftype = 3;
b = f_firparks (m,F_p,F_s,delta_p,delta_s,ftype,fs);
[H,f] = f_freqz (b,a,N,fs);
AdB = 20*log10(abs(H));
A_stop = -max(AdB(i_stop))
figure
caption = sprintf ('Equiripple filter, {\\itm} = %d, {\\itA_s} = %.1f dB',m,A_stop);
f_labels (caption,'{\itf} (Hz)','{\itA(f)} (dB)')
axis ([0 fs/2 -A_min A_max])
hold on
box on
fill ([0 F_p(1) F_p(1) 0],[-A_p -A_p A_p A_p],'c')
fill ([F_s(1) F_s(2) F_s(2) F_s(1)],[-A_min -A_min -A_s -A_s],'c')
fill ([F_p(2) fs/2 fs/2 F_p(2)],[-A_p -A_p A_p A_p],'c')
plot (f,AdB,'LineWidth',1.5)
f_wait

function A = bandstop (f,fs,p)

% BANDSTOP: Amplitude response of bandstop filter 
%
%           p(1) = F_p1
%           p(2) = F_s1
%           p(3) = F_s2
%           p(4) = F_p2

A = zeros(size(f));
for i = 1 : length(f)
    if (f(i) <= p(1) | f(i) >= p(4))
        A(i) = 1;
    elseif (f(i) > p(1) & f(i) < p(2))
        A(i) = 1 - (f(i) - p(1))/(p(2)-p(1));
    elseif (f(i) > p(3) & f(i) < p(4))
        A(i) = (f(i) - p(3))/(p(4) - p(3));
    end
end
