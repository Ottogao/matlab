function exam5_14

% EXAMPLE 5.14: IIR coefficient quantization 

clear
clc
fprintf('Example 5.14: IIR coefficient quantization\n')
n = 9;
r = 0.98;
b = 1 - r^n
a = zeros(1,n);
a(1) = 1;
a(n) = -r^n
N = f_prompt ('Enter the number of bits',2,32,4);

% Compute quantized filter

c = 2;
q = c/2^(N-1);
b_q = f_quant(b,q,0);
a_q = f_quant(a,q,0);

% Compare frequency responses

m = 512;
fs = 1;
[H,f] = f_freqz (b,a,m,fs);
[H_q,f] = f_freqz (b_q,a_q,m,fs);
figure
A = 20*log10(abs(H));
A_q = 20*log10(abs(H_q));
h = plot (f,A,f,A_q);
set (h(1),'LineWidth',1.5)
axis ([0 .5 -25 5])
f_labels ('Magnitude responses','\it{f/f_s}','{\itA(f)} (dB)')
legend ('Unquantized','Quantized')
f_wait
