function exam7_8

% Example 7.8: An oversampling ADC 

clear
clc
fprintf('Example 7.8: An oversampling ADC\n\n')
M = 1 : 40;

% Compute aliasing errors

for n = 1 : 4
   alpha(n,:) = log10(1 ./ sqrt(1 + (M .^ (2*n))));
end

% Plot them

figure
hp = plot (M,alpha(1,:),M,alpha(2,:),M,alpha(3,:),M,alpha(4,:));
set (hp,'LineWidth',1.5)
f_labels ('Logarithm of aliasing error scale factor','\it{M}','log_{10}(\alpha_n)')
text (25,-1.1,'{\itn} = 1')
text (25,-2.5,'{\itn} = 2')
text (25,-3.9,'{\itn} = 3')
text (25,-5.3,'{\itn} = 4')
f_wait
