function exam4_6

% EXAMPLE 4.6:  Fast convolution 

clear
clc
fprintf('Example 4.6: Fast convolution\n')

% Construct impulse response h and input x

L = 512;
k = 0 : L-1;
h = 0.98.^k .* sin(pi*k/24);
x = (k.^2).*(0.99.^k).*cos(pi*k/48);

% Compute zero-state output y using fast convolution

y = f_conv(h,x,0);
i = 0 : length(y)-1;
figure
h = plot (k,x,i,y);
set (h(2),'LineWidth',1.5)
f_labels ('Input and zero-state output','\it{k}','signals')
legend ('Input','Zero-state output')

% Compute number of FLOPs

n_fast = 12*L*log(2*L) + 8*L + 4
n_direct = 2*L^2
f_wait
