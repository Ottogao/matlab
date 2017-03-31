function fig9_38

% Figure 9.38: Gausaian and raised-cosine radial basis functions 

clear
clc
fprintf('Figure 9.38: Gaussian and raised-cosine radial basis functions\n\n')

% Compute RBFs

p = 201;
z = linspace (-2,2,p);
sigma = 1;
G_1 = exp(-z.^2 /sigma^2);
for i = 1 : p
    if abs(z(i)) > 1
        G_2(i) = 0;
    else
        G_2(i) = (1 + cos(pi*z(i)))/2;
    end
end

% Plot them

figure
h = plot (z,G_1,z,G_2);
set (h(2),'LineWidth',1.5);
axis ([-2 2 -0.2 1.2])
f_labels ('Gaussian and raised-cosine RBFs','\it{z}','\it{G(z)}')
legend ('Gaussian','Raised cosine')
hold on
plot ([-1 -1],[-.15 -.05],'k')
plot ([1 1],[-.15 -.05],'k')
text (-.19,-0.1,'Support')
f_wait
