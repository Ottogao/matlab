function exam5_12

% EXAMPLE 5.12: FIR coefficient quantization 

clear
clc
fprintf('Example 5.12: FIR coefficient quantization\n\n')
N = f_prompt ('Enter the number of bits',2,32,8);

% Construct bandpass filter

m=64;
fs = 20;
b = f_firideal (2,[3,7],m,fs,3);

% Compute quantized filter

c = ceil(max(abs(b)))
q_b = c/2^(N-1)
b_q = f_quant(b,q_b,0);
a = 1;

% Compare frequency responses

r = 512;
fs = 1;
[H,f] = f_freqz (b,a,r,fs);
[H_q,f] = f_freqz (b_q,a,r,fs);
figure
A = 20*log10(max(abs(H),eps));
subplot(2,1,1)
plot (f,A,'LineWidth',1.5)
axis ([0 fs/2 -120 20])
f_labels ('(a) Unquantized coefficients','\it{f/f_s}','{\itA(f)} (dB)')
A_q = 20*log10(max(abs(H_q),eps));
subplot (2,1,2)
plot (f,A_q,'LineWidth',1.5)
axis ([0 fs/2 -120 20])
f_labels ('(b) Coefficients quantized to 8 Bits','\it{f/f_s}','{\itA(f)} (dB)')
f_wait
