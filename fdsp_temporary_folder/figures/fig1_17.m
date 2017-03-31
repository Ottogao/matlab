function fig1_17

% FIGURE 1.17: Sampled version of a signal

clc
clear
fprintf ('Figure 1.17: Sampled version of a signal\n\n')
f = inline ('10*t.*exp(-t)','t');
p = 101;
tau = 4;
n = 16;
T = tau/n;
awid = tau/50;
alen = 2/20;

% Impulse train

figure
subplot(2,1,1)
hold on
for i = 1 : n
   ti = (i-1)*T;
   xi = 1 - alen;
   plot([ti ti],[0 xi],'LineWidth',1.2);
   plot([ti-awid/2 ti ti+awid/2 ti-awid/2],[xi xi+alen xi xi],'LineWidth',1.5);
end
axis([0 4 0 2])
f_labels ('','{\itt} (sec)','{\it\delta_T(t)}')
box on
hold off

% Sampled Version of x_a(t)

alen = 4/20;
subplot(2,1,2)
hold on
t = linspace(0,tau,p);
x_a = f(t);
plot(t,x_a,'r--')
for i = 1 : n
   ti = (i-1)*T;
   xi = f(ti) - alen;
   plot([ti ti],[0 xi],'LineWidth',1.2);
   plot([ti-awid/2 ti ti+awid/2 ti-awid/2],[xi xi+alen xi xi],'LineWidth',1.5);
end
axis([0 4 0 4])
f_labels ('','{\itt} (sec)','{\itx_a^{\ast}(t)}')
hold off
box on
f_wait
   