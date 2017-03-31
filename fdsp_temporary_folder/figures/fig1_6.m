function fig1_6

% FIGURE 1.6:  Active noise control in an air duct 

clear
clc
fprintf('Figure 1.6: Active noise control in an air duct\n\n')
rand('seed',1000)
N = f_prompt ('Enter number of samples',1,5000,2048);
m = f_prompt ('Enter order of adaptive filter',0,100,40);
n = f_prompt ('Enter order of primary and secondary fitler',0,50,20);
r = f_prompt ('Enter number of harmonics',1,9,4);
delta = f_prompt ('Enter amplitude of white noise',0,1,0.5);
mu = f_prompt ('Enter step size',0,1,0.0001);

% Construct models of primary and secondary systems

g = f_randu (n+1,1,-1,1);
f = f_randu (n+1,1,-1,1);

% Construct noisy periodic input 

k = [1 : N]';
fs = 1600;
f_0 = 100;
T = 1/fs;
phi = f_randu(r,1,-pi,pi);
x = f_randu (N,1,-delta,delta);
for i = 1 : r
    a = 1/i;
    psi = 2*pi*i*f_0*k*T + phi(i);
    x = x + cos(psi);
end

% Apply active noise control starting at sample N/4+1

e = filter (g,1,x);         
p = [N/4 + 1:N];
[w,e(p)] = f_fxlms (x(p),g,f,m,mu);

% Compute noise cancellation

E = real(10*log10(sum(e(1:N/4).^2)/sum(e(3*N/4+1:N))))
s = sprintf ('Noise reduction = %.1f dB',E);

% Display squared error

figure
stem (k,e(k).^2,'filled','.')
f_labels ('Squared error','{\itk}','{\ite^2(k)}')
axis ([0 N 0 100])
text (N/2,0.6*max(e.^2),s)
f_wait
