function fig8_5

% Figure 8.5: Generation of colored noise 

clear
clc
fprintf('Figure 8.5: Generation of colored noise\n\n')
N = 2048;
fs = 800;
F_p = [150 300];
F_s = [120 330];
delta_p = 0.05;
delta_s = 0.05;
rand('state',1000)

% Compute filter coefficients

ftype = 2;
[b,a] = f_ellipticz (F_p,F_s,delta_p,delta_s,ftype,fs);
n = length(a)-1

% Compute colored noise

v = f_randu(1,N,-1,1);
x = filter(b,a,v);
P_x = sum(x.^2)/N
blackman = 4;
welch = 1;
L = 256;
[S,f,P_x] = f_pds (x,N,L,fs,blackman,welch);
figure
plot(f(1:L/2),S(1:L/2),'LineWidth',1.0)
axis([0,fs/2,0,1])
f_labels('Power density spectrum of colored noise','{\itf} (Hz)','\it{S_W(f)}')
text (15,-.25,'Red')
text (365,-.25,'Blue')
f_wait
