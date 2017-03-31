function fig5_4

% FIGURE 5.4   Coefficient quantization error 

clear
clc
fprintf('Example 5.4: Coefficient quantization error\n\n')

% Compute filter coefficients

fs = 1;
F_p = 0.15;
F_s = 0.25;
delta_p = 0.08;
delta_s = delta_p;
ftype = 0;
[b,a] = f_cheby1z (F_p,F_s,delta_p,delta_s,ftype,fs);

% Quantize the coefficients and plot the magnitude responses

color = ['b','g','r'];
c = ceil(max([abs(b) abs(a)]));
M = 250;
A = zeros(3,M);
N = 3;
for i = 1 : 3
   N = N + 3;
   q = c/2^(N-1);
   if N == 4
      q = 0;
   end
   b_q = f_quant (b,q,0);
   a_q = f_quant (a,q,0);
   [H,f] = f_freqz (b_q,a_q,M,fs);
   A(i,:) = abs(H);
end
figure
hold on
A1 = 1 - delta_p;
A2 = delta_s;
fill ([0 F_p F_p 0],[A1 A1 1 1],'c')
fill ([F_s 0.5 0.5 F_s],[0 0 A2 A2],'c')
plot (f,A,'LineWidth',1.0)
axis ([0 fs/2 0 1.2])
f_labels ('Magnitude responses','\it{f/f_s}','\it{A(f)}')
text (0.09,0.42,'\it{N}=6')
text (0.05,1.1,'\it{N}=9')
text (0.09,0.86,'\it{N}=12')
box on
f_wait
