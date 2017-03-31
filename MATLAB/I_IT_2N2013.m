cu =[ 105 91 78 64 86 99 17 82 38 56 79 142 89 71 12 71 51 76 95 53 57 75 81 95 93 57 68 59 97 34 93 118.5 72 88 61 ];
cumin = min(cu);
cumax = max(cu);
scale = 40:10:110;
distrib = hist(cu, scale);
bar(scale, distrib)
ylabel('No. of students');
xlabel('Credit units achieved');
title('Distribution of CU achievement');