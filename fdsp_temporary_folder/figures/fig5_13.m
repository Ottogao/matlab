function fig5_13

% FIGURE 5.13: Impulse responses of linear-phase FIR filters 

clear
clc
fprintf('Figure 5.13: Impulse responses of linear-phase FIR filters\n\n')

% Construct filters

r = 12;
m = [r-1 r r-1 r];
mmax = max(m);
b = zeros(4,mmax);
for i = 1 : 4
   for j = 1 : floor((m(i)+1)/2)
      b(i,j) = (j-1)^2;
      if i < 3
         b(i,m(i)+1-j) = b(i,j);
      else
         b(i,m(i)+1-j) = -b(i,j);
      end
      if i == 3
         b(i,(m(i)+1)/2) = 0;
      end
   end
end

% Plot pulse responses

figure
c = 40;
for i = 1 : 4
   subplot(2,2,i)
   hp = stem (0:m(i)-1,b(i,1:m(i)),'filled','.');
   set (hp,'LineWidth',1.5)
   axis ([0 mmax -c c])
   hold on
   plot ([(m(i)-1)/2 (m(i)-1)/2],[-c c],'--k')
   switch i
      case 1, f_labels ('Type 1 filter, {\itm} = 10','\it{k}','\it{h}_1\it{(k)}')
      case 2, f_labels ('Type 2 filter, {\itm} = 11','\it{k}','\it{h}_2\it{(k)}')
      case 3, f_labels ('Type 3 filter, {\itm} = 10','\it{k}','\it{h}_3\it{(k)}')
      case 4, f_labels ('Type 4 filter, {\itm} = 11','\it{k}','\it{h}_4\it{(k)}')
   end
end
f_wait
   