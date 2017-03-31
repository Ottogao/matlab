function exam5_6

% EXAMPLE 5.6:  Allpass minimum-phase decomposition 

clear
clc
fprintf('Example 5.6: Allpass minimum-phase decomposition\n\n')
r = sqrt(.5^2 + 1.5^2);
theta = atan2(1.5,-.5);
b0 = 0.2;
z = r*[exp(j*theta), exp(-j*theta)];
b = b0*poly(z)
a = [1 0 -.64]

% Sketch pole-zero plots  (use f_pzplot?)

x1 = -0.5;
y1 = 1.5;
p1 = 0.8;
p2 = -0.8;
r = 1;
c = .05;
phi = linspace(0,2*pi,361);
x = r*cos(phi);
y = r*sin(phi);
figure
box off
d = 2.0;
hp = plot(x,y,'b',[-d d],[0 0],'k',[0 0],[-d d],'k');
set (hp(1),'LineWidth',1.5)
axis ([-d d -d d]);
axis square
f_labels ('Filter \it{H(z)}','Re({\itz})','Im({\itz})')
text (x1-c,y1,'0')
text (x1-c,-y1,'0')
text (-c+p1,0,'X')
text (-c+p2,0,'X')
f_wait

% Find minimum-phase and allpass factors

[b_min,a_min,b_all,a_all] = f_minall (b,a)

% Compute frequency responses

n = 300;
[H(1,:),f] = f_freqz (b,a,n);
[H(2,:),f] = f_freqz (b_min,a_min,n);
[H(3,:),f] = f_freqz (b_all,a_all,n);
A = abs(H);
phi = angle(H);

% Plot them

figure
subplot(2,1,1)
h = plot(f,A);
set (h(1),'LineWidth',1.5)
f_labels('Magnitude responses','\it{f/f_s}','\it{A(f)}')
text (.04,1.9,'\it{A}')
text (.25,1.2,'{\itA}_{all}')
text (.25,0.4,'{\itA}_{min}')
subplot(2,1,2)
h = plot(f,phi);
set (h(1),'LineWidth',1.5)
f_labels('Phase responses','\it{f/f_s}','\phi({\itf})')
text (.09,0.3,'\phi_{all}')
text (.17,-2.4,'\phi')
text (.33,-0.2,'\phi_{min}')
f_wait
