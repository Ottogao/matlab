%function [mean,deviation]=findmean(mu,sigma)
mean=60;
deviation=15;
str1=strcat('exp(mu+(sigma^2/2))=',num2str(mean));
str2=strcat('sqrt((exp(sigma^2)-1)*exp(2*mu+sigma^2))=',num2str(deviation));


S=solve(str1,str2);

x=S.mu,y=S.sigma