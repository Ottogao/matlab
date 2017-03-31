function exam9_15

% Example 9.15: Active noise control with the signal synthesis method 

clear
clc
fprintf('Example 9.15: Active noise control with the signal synthesis method\n\n')
rand('seed',1000)
N = f_prompt ('Enter number of samples',1,5000,2400);
m = f_prompt ('Enter order of primary and secondary fitler',0,50,20);
r = f_prompt ('Enter number of harmonics',1,9,5);
delta = f_prompt ('Enter amplitude of white noise',0,1,0.5);
mu = f_prompt ('Enter step size',0,1,0.001);

% Construct models of primary and secondary systems

g = f_randu (m+1,1,-1,1);
f = f_randu (m+1,1,-1,1);

% Construct noisy periodic input 

k = [1 : N]';
f_s = 2000;
f_0 = 100;
T = 1/f_s;
x = f_randu (N,1,-delta,delta);
a = f_randu (r,1,-1,1);
b = f_randu (r,1,-1,1);
for i = 1 : r
    phi = 2*pi*i*f_0*k*T;
    x = x + a(i)*cos(phi) + b(i)*sin(phi);
end

% Apply active noise control starting at sample N/4+1

e = filter (g,1,x);         
c = [N/4 + 1:N];
[p,q,e(c)] = f_sigsyn (x(c),g,f,f_0,f_s,r,mu);
p
q

% Compute noise cancellation

E = real(10*log10(sum(e(1:N/4).^2)/sum(e(3*N/4+1:N))))
s = sprintf ('Noise reduction = %.1f dB',E);

% Display squared error

figure
stem (k,e(k).^2,'filled','.')
f_labels ('Squared error','\it{k}','\it{e^2(k)}')
%axis ([0 N 0 100])
text (N/2,0.6*max(e.^2),s)
f_wait

% Display power spectrum of noise

[A_u,phi_u,S_u,f] = f_spec (e(1:N/4),N/4,f_s);
[A_c,phi_c,S_c,f] = f_spec (e(3*N/4+1:N),N/4,f_s);
figure
subplot(2,1,1)
i = 1 : N/8;
plot (f(i),A_u(i),'LineWidth',1.0)
f_labels ('','{\itf} (Hz)','\it{A_u(f)}')
subplot(2,1,2)
plot (f(i),A_c(i),'LineWidth',1.0)
f_labels ('','{\itf} (Hz)','\it{A_c(f)}')
axis([0 f_s/2 0 1500])
f_wait
