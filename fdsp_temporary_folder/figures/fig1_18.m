function fig1_18

% FIGURE 1.18: The spectrum of a sampled signal with aliasing

clc
clear
fprintf ('Figure 1.18: The spectrum of a sampled signal with aliasing\n\n')
B = 100;
fs = 3*B/2;
T = 1/fs;
f_d = fs/2;

% Plot Spectrum of x_a(t)

figure
p = 501;
fmax = 2*fs;
f = linspace(-fmax,fmax,p);
for i = 1 : p
   if (f(i) >= -B) & (f(i) <= 0)
      X_a(i) = (1/B)*f(i) + 1;
   elseif (f(i) > 0) & (f(i) <= B)
      X_a(i) = -(1/B)*f(i) + 1;
   else
      X_a(i) = 0;
   end
end
subplot(2,1,1)
plot(f,X_a,'LineWidth',1.5)
axis ([-fmax fmax 0 2])
f_labels ('','{\it f}(Hz)','|{\itX_a(f)}|')
xticks = [-300 : 50 : 300];
set(gca,'XTick',xticks)
xticklabels = '-300 | | -200 | | -100 | | 0 | | 100 | | 200 | | 300';
set(gca,'XTickLabel',xticklabels)
text (fs,-0.2,'{\itf_s}')
text (-fs-10,-0.2,'{\it-f_s}')

% Plot Spectrum of Sampled Signal

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
   if (f3 >= 0) & (f3 <= B)
      X_t(i) = (-(1/B)*f3 + 1)/T;
   elseif (f4 >= -B) & (f4 <= 0)
      X_t(i) = ((1/B)*f4 + 1)/T;
   else
      X_t(i) = 0;
   end
end

subplot(2,1,2)
X = X_b + X_s + X_t;
plot(f,X_b,f,X_s,'b',f,X_t,'b',f,X)
hold on
plot(f,X,'LineWidth',1.5)
axis ([-fmax fmax 0 1.5/T])
f_labels ('','{\itf} (Hz)','|{\itX_a^{\ast}(f)}|')
set(gca,'XTick',xticks)
set(gca,'XTickLabel',xticklabels)
text (fs,-25,'{\itf_s}')
text (-fs-10,-25,'{\it-f_s}')
text (0.90*f_d,1.1/T,'{\itf_d}')

% Shading of aliased areas

y = [0 0 40]; 
for i = 0 : 3
    x(1) = -250 + 150*i;
    x(2) = -200 + 150*i;
    x(3) = -225 + 150*i;
    fill (x,y,'c')
end
plot([f_d f_d],[0 1/T],':')
f_wait
