function fig8_16

% Figure 8.16: Poles of normalized lowpass Butterworth filters 

clc
clear
fprintf ('Figure 8.16: Poles of normalized lowpass Butterworth filters\n\n')
fc = 1/(2*pi);
m = 250;
theta = linspace(0,2*pi,m);
x = cos(theta);
y = sin(theta);
s = 2;

% Plot poles when n = 5;

n = 5;
k = 0 : n-1;
p = 2*pi*fc*exp(j*pi*(n+1+2*k)/(2*n));
x0 = real(p);
y0 = imag(p);
figure
subplot(1,2,1)
box off
plot([-s s],[0 0],'k',[0 0],[-s s],'k')
axis square
f_labels ('Odd order: {\itn} = 5','Re({\its})','Im({\its})')
hold on
for i = 1 : n
   plot(x0(i),y0(i),'rX')
end
plot(x,y,'LineWidth',1.5)

% Plot poles when n = 6;

n = 6;
k = 0 : n-1;
p = 2*pi*fc*exp(j*pi*(n+1+2*k)/(2*n));
x0 = real(p);
y0 = imag(p);
subplot(1,2,2)
box off
plot([-s s],[0 0],'k',[0 0],[-s s],'k')
axis square
f_labels ('Even order: {\itn} = 6','Re({\its})','Im({\its})')
hold on
for i = 1 : n
   plot(x0(i),y0(i),'rX')
end
plot(x,y,'LineWidth',1.5)
f_wait 
