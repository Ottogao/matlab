function exam3_17

% EXAMPLE 3.17: Distortion due to clipping 

clear
clc
fprintf('Example 3.17: Distortion due to clipping\n')
 
% Construct input and output

N = 32;
k = 0 : N-1;
fs = 20000;
T = 1/fs;
fa = fs/N;
c = 0.70;
x = cos(2*pi*fa*k*T);
y = f_clip(x,-c,c);

% Plot clipped signal

figure
h = plot (k,x,'--',k,y);
set (h(2),'LineWidth',1.5)
axis([k(1),k(N),-1.5,1.5])
legend ('Cosine','Clipped Cosine')
f_labels ('Clipped cosine','\it{k}','\it{y(k)}')
f_wait

% Compute total harmonic distortion

A = abs(fft(y));
d = 2*A/N;
Delta_f = fs/N;
i = round(fa/Delta_f) + 1;
P_y = d(1)^2/4 + (1/2)*sum(d(2:N/2).^2)
D = 100*(P_y - (d(i)^2)/2)/P_y

% Compute and plot magnitude spectrum

figure
i = 1 : N/2;
hp = stem (i-1,A(i),'filled','.');
set (hp,'LineWidth',1.5);
f_labels('Magnitude spectrum','\it{i}','\it{A(i)}')
set(gca,'Xlim',[0,N/2])
f_wait
 