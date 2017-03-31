function f_ploterase (han)

%F_PLOTERASE: Erase the the plot area used by GUI modules
%
% Inputs:
%          han= array of axes handles

for i = 6 : 10
    axes (han(i))
    cla
    f_labels ('','','')
    axis off
    if i == 6
        legend off
    end
end
