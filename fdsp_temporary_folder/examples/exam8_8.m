function exam8_8

% Example 8.8: Bilinear transformation method 

clear
clc
fprintf('Example 8.8: Bilinear transformation method\n\n')
fs = 20;
T = 1/fs;
f_1 = .25*fs/2;
f_2 = .75*fs/2;
delta_p = 0.1;
delta_s = 0.1;
  
% Compute analog fitler parameters

F_1 = tan(pi*f_1*T)/(pi*T)
F_2 = tan(pi*f_2*T)/(pi*T)
d1 = (1-delta_p)^(-2) - 1;
d2 = delta_s^(-2) - 1;
n = log(d1/d2)/(2*log(F_1/F_2))
n = ceil(n)

% Find analog transfer function

F_c = F_1/(d1^(1/(2*n)))
[bs,as] = f_butters (F_1,F_2,delta_p,delta_s)

% Find digital transfer function

[bz,az] = f_bilin (bs,as,fs)

% Find frequency response

figure
q = 250;
[H,f] = f_freqz (bz,az,q,fs);
A = abs(H);
plot(f,A,'LineWidth',1.5)
axis ([0 fs/2 0 1.2])
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
hold on
fill ([0 f_1 f_1 0],[1-delta_p 1-delta_p 1 1],'c')
plot ([f_1 f_1],[0 1-delta_p],'k--')
plot ([0 f_2],[delta_s delta_s],'k--')
fill ([f_2 fs/2 fs/2 f_2],[0 0 delta_s delta_s],'c')
plot(f,A)
text (f_1-.1,-.05,'\it{F_p}')
text (f_2-.1,-.05,'\it{F_s}')
text (-.8,1-delta_p,'1 - \delta_p')
text (-.4,delta_s,'\delta_s')
f_wait
