function exam5_17

% EXAMPLE 5.17: Highpass elliptic filter 

clear
clc
fprintf('Example 5.17: Highpass elliptic filter\n')
fs = 200;
F_s = f_prompt ('Enter stopband cutoff frequency',0,fs/2,40);
F_p = f_prompt ('Enter passband cutoff frequency',F_s,fs/2,42);
delta_p = f_prompt ('Enter passband ripple factor',0,0.5,0.05);
delta_s = f_prompt ('Enter stopband attenuation factor',0,0.5,0.05);
N = f_prompt ('Enter number of bits of precision',2,64,10);

% Compute filter coefficients

f_type = 1;
[b,a] = f_ellipticz (F_p,F_s,delta_p,delta_s,f_type,fs);
n = length(a) - 1

% Compute quantized filter coefficients

c = max(abs([a(:) ; b(:)]));
c = 2^ceil(log(c)/log(2))
q = c/2^(N-1)
a_q = f_quant (a,q,0);
b_q = f_quant (b,q,0);

% Compute and plot magnitude responses

p = 250;
[H,f] = f_freqz (b,a,p,fs);
A = abs(H);
[H_q,f] = f_freqz (b_q,a_q,p,fs);
A_q = abs(H_q);
figure
h = plot (f,A,f,A_q);
set (h(1),'LineWidth',1.5)
f_labels ('Magnitude responses','{\itf }(Hz)','\it{A(f)}')
q_str = sprintf ('Quantized, {\\itN} = %d',N);
legend ('Unquantized',q_str)
hold on
fill ([0 F_s F_s 0],[0 0 delta_s delta_s],'c')
fill ([F_p fs/2 fs/2 F_p],[1-delta_p 1-delta_p 1 1],'c')
h = plot (f,A,f,A_q);
set (h(1),'LineWidth',1.5)
f_wait

% Pole-zeros plots

figure
subplot (2,2,1)
f_pzplot(b,a,'Unquantized filter');
axis ([-1.5 1.5 -1.5 1.5])
for N = [10 8 6]
    q = c/(2^(N-1));
    a_q = f_quant (a,q,0);
    b_q = f_quant (b,q,0);
    switch N
        case 10, subplot (2,2,2);
        case 8, subplot (2,2,3);
        case 6, subplot (2,2,4)
    end
    caption = sprintf ('Quantized filter, {\\itN} = %d',N);
    f_pzplot (b_q,a_q,caption);
    axis ([-1.5 1.5 -1.5 1.5])
end
f_wait
