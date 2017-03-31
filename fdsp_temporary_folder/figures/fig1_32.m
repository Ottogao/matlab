function fig1_32

% FIGURE 1.32: Magnitude spectra of DAC input and output with oversampling

clc
clear
fprintf ('Figure 1.32: Magnitude spectra of DAC input and output with oversampling\n\n')
B = 100;
fs = 4*B;
T = 1/fs;
f_d = fs/2;

% Plot Spectrum of DAC Input 

figure
p = 501;
fmax = 2.5*fs;
f = linspace(-fmax,fmax,p);

% Base band

for i = 1 : p
   if (f(i) >= -B) & (f(i) <= 0)
      X_b(i) = ((1/B)*f(i) + 1)/T;
   elseif (f(i) > 0) & (f(i) <= B)
      X_b(i) = (-(1/B)*f(i) + 1)/T;
   else
      X_b(i) = 0;
   end
end

% Side bands

for i = 1 : p
   f1 = f(i) + fs;
   f2 = f(i) - fs;
   if (f1 >= -B) & (f1 <= 0)
      X_s(i) = ((1/B)*f1 + 1)/T;
   elseif (f1 > 0) & (f1 <= B)
      X_s(i) = (-(1/B)*f1 + 1)/T;
   elseif (f2 >= -B) & (f2 <= 0)
      X_s(i) = ((1/B)*f2 + 1)/T;
   elseif (f2 > 0) & (f2 <= B)
      X_s(i) = (-(1/B)*f2 + 1)/T;
   else
      X_s(i) = 0;
   end
end

for i = 1 : p
   f3 = f(i) + 2*fs;
   f4 = f(i) - 2*fs;
   if (f3 >= -B) & (f3 <= 0)
      X_t(i) = ((1/B)*f3 + 1)/T;
   elseif (f3 >= 0) & (f3 <= B)
      X_t(i) = (-(1/B)*f3 + 1)/T;
   elseif (f4 >= -B) & (f4 <= 0)
      X_t(i) = ((1/B)*f4 + 1)/T;
   elseif (f4 > 0) & (f4 <= B)
      X_t(i) = (-(1/B)*f4 + 1)/T;
   else
      X_t(i) = 0;
   end
end

subplot(2,1,1)
X = X_b + X_s + X_t;
plot(f,X,'LineWidth',1.5)
hold on
plot(f,X+1,f,X+2)
axis ([-fmax fmax 0 1.5/T])
xticks = [-fmax : fs/2 : fmax];
set(gca,'XTick',xticks)
xticklabels = '| -800 | | -400 | | 0 | | 400 | | 800 |';
set(gca,'XTickLabel',xticklabels)
f_labels ('DAC magnitude spectra with oversampling','{\itf} (Hz)','|{\itY_a^{\ast}(f)}|')

% Plot spectrum of DAC output

for i = 1 : p
   s = j*2*pi*f(i);
   if (i == (p+1)/2)
      A(i) = T;
   else
      A(i) = abs((1 - exp(-s*T))/s);
   end
   X_b(i) = A(i)*X_b(i);
   X_s(i) = A(i)*X_s(i);
   X_t(i) = A(i)*X_t(i);
end

subplot(2,1,2)
X = X_b + X_s + X_t;
plot(f,X,'r','LineWidth',1.5)
hold on
axis ([-fmax fmax 0 1.5])
xticks = [-fmax : fs/2 : fmax];
set(gca,'XTick',xticks)
xticklabels = '| -800 | | -400 | | 0 | | 400 | | 800 |';
set(gca,'XTickLabel',xticklabels)
f_labels ('','{\itf} (Hz)','|{\itY_b(f)}|')
f_wait
