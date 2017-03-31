function exam5_5

% EXAMPLE 5.5:  Minimum-phase filter 

clear
clc
fprintf('Example 5.5: Minimum-phase filter\n\n')
r = [.5 -.5];
s = 2;
b1 =s*poly(r);
n = 256;
a = [1 -1 .5];

% Compute other numerator polynomials

b2 = -r(1)*s*poly([1/r(1),r(2)]);
b3 = -r(2)*s*poly([r(1),1/r(2)]);
b4 = r(1)*r(2)*s*poly([1/r(1),1/r(2)]);

% Compute frequency responses

[H(1,:),f] = f_freqz (b1,a,n);
[H(2,:),f] = f_freqz (b2,a,n);
[H(3,:),f] = f_freqz (b3,a,n);
[H(4,:),f] = f_freqz (b4,a,n);

% Plot magnitudes and phases

figure
A = abs(H);
plot(f,A,'LineWidth',1.5)
f_labels ('Magnitude responses','\it{f/f_s}','\it{A(f)}')
f_wait
figure
phi = angle(H);
plot(f,phi,'LineWidth',1.5)
f_labels ('Phase responses','\it{f/f_s}','\phi{\it(f)}')
text(.35,-0.6,'\phi_{00}')
text(.35,-1.85,'\phi_{10}')
text(.35,2.85,'\phi_{01}')
text(.35,1.6,'\phi_{11}')
f_wait
