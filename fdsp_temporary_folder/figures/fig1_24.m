function fig1_24

% FIGURE 1.24: Reconstruction of x_a(t) with a zero-order hold

clc
clear
fprintf ('Figure 1.24: Reconstruction of x_a(t) with a zero-order hold\n\n')
f = inline ('10*t.*exp(-t)','t');
p = 101;
tau = 4;
n = 16;
T = tau/n;
dy = .05;
awid = tau/50;
alen = 2/20;

% Sampled Version of x_a(t)

figure
hold on
t = linspace(0,tau,p);
x_a = f(t);
plot(t,x_a,'g--')
for i = 1 : n
   ti = (i-1)*T;
   xi = f(ti)-alen;
   plot([ti ti],[0 xi])
   plot([ti-awid/2 ti ti+awid/2 ti-awid/2],[xi xi+alen xi xi]);
end
axis ([0 tau 0 4])
f_labels ('','{\itt} (sec)','{\ity_a(t)}')

% Reconstructed x_a(t)

for i = 1 : n
   x1 = [i-1 : i]*T;
   y1 = [1 1]*f((i-1)*T);
   plot (x1,y1,'r','LineWidth',1.5);
   x2 = [i i]*T;
   y2 = [f((i-1)*T) f(i*T)];
   plot (x2,y2,'r','LineWidth',1.5)
end

% Label plots

text (.18,2.65,'{\it x_a}')
text (1.24,2.65,'{\it x_a^{\ast}}')
text (2.28,2.65,'{\it y_a}')
box on
f_wait
