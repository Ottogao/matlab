function exam4_7

% EXAMPLE 4.7:  Fast block convolution 

clear
clc
fprintf('Example 4.3.2: Fast Block Convolution\n')

% Construct impulse response h and input x

L = f_prompt ('Enter length of impulse response',2,32,12);
M = f_prompt ('Enter length of white noise input',L,10*L,6*L-2);
k = 0 : L-1;
h = 0.8.^k .* sin(pi*k/4);
rand('seed',500)
x = f_randu(1,M,-1,1);
(k.^2).*(0.98.^k).*cos(pi*k/24);
ny = L + M - 1;

% Compute zero-state output y using fast block convolution

y = f_blockconv(h,x);
r = L - mod(M,L);
M = M + r
x_z = [f_torow(x) zeros(1,r)];
Q = M/L
N = 2^(ceil(log(2*L-1)/log(2)))

% Plot output

figure
subplot(3,1,3)
k = 0 : length(y)-1;
y1 = f_conv(h,x,0);
hp = stem(k,y,'filled','.');
set (hp,'LineWidth',1)
hold on
hp = stem (k,y1,'filled','.');
set (hp,'LineWidth',1)
f_labels ('','\it{k}','\it{y(k)}')
klim = get(gca,'Xlim');

% Plot impulse response

subplot (3,1,1)
hp = stem (0:L-1,h,'filled','.');
set (hp,'LineWidth',1)
axis ([0 klim(2) -1 1])
hold on
plot ([L-1 L-1],[-1 1],'k--')
f_labels ('Block convolution','\it{k}','\it{h(k)}')

% Plot partitioned input

subplot(3,1,2)
b = 2;
x_z = [f_torow(x) zeros(1,r)]; 
hp = stem(0:length(x_z)-1,x_z,'filled','.');
set (hp,'LineWidth',1)
axis([0 klim(2) -b b])
hold on
for i = 1 : Q
    plot([i*L-1,i*L-1],[-b,b],'k--')
end
f_labels ('','\it{k}','\it{x(k)}')
f_wait
