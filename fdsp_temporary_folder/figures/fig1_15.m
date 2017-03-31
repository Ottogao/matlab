function fig1_15

% FIGURE 1.15: Impulse response of an ideal lowpass filter

clc
clear
fprintf ('Figure 1.15: Impulse response of an ideal lowpass filter:\n\n')
p = 401;
B = 100;
tmax = .04;

% Compute and plot impulse pulse respones

figure
t = linspace(-tmax,tmax,p);
for i = 1 : p
   if t(i) ~= 0
      h(i) = 2*B*sin(2*pi*B*t(i))/(2*pi*B*t(i));
   else
      h(i) = 2*B;
   end
end
r = plot(t,h,t,zeros(1,p),'k',[0 0],[-50 250],'k');
set (r(1),'LineWidth',1.5)
axis ([t(1) t(p) -50 250])
f_labels ('Impulse response','{\itt} (sec)','{\ith_a(t)}')
f_wait
