function exam6_7

% EXAMPLE 6.7:  Least-squares bandpass filter 

clear
clc
fprintf('Example 6.7: Least-squares bandpass filter\n\n')
fs = 1;
p = f_prompt('Enter number of discrete frequencies',2,100,40);
df = fs/32;
Fp = [3*fs/16, 5*fs/16];
Fs = [Fp(1)-df, Fp(2)+df];
i = 0 : p;
F = i*fs/(2*p);
w = ones(1,p+1);
m = f_prompt ('Enter fitler order',2,2*p,p);

% Compute desired amplitude resposne

A = zeros(1,p+1);
for i = 1 : p+1
   if (F(i) >= Fs(1)) & (F(i) < Fp(1))
      A(i) = (F(i)-Fs(1))/df;
   end
   if (F(i) >= Fp(1)) & (F(i) <= Fp(2))
      A(i) = 1;
      w(i) = 10;
   end
   if (F(i) > Fp(2)) & (F(i) <= Fs(2))
      A(i) = 1 - (F(i)-Fp(2))/df;
   end
end

% Find least squares filter

b = f_firls (F,A,m,fs);

% Compute and display magnitude responses

N = 250;
[H,f] = f_freqz (b,1,N,fs);
figure
subplot(2,1,1)
h = plot(F,A,'k',f,abs(H));
set (h(2),'LineWidth',1.5)
f_labels ('Uniform weighting','\it{f/f_s}','\it{A(f)}')
legend ('Ideal','LS fitler')

% Change weights

b = f_firls (F,A,m,fs,w);
[H,f] = f_freqz (b,1,N,fs);
subplot(2,1,2)
h = plot(F,A,'k',f,abs(H));
set (h(2),'LineWidth',1.5)
legend ('Ideal','Weighted LS fitler')
f_labels ('Passband weighting','\it{f/f_s}','\it{A(f)}')
f_wait
