
function [mean,deviation]=getmean(mu,sigma)


mean=exp(mu+(sigma^2/2));
deviation=(exp(sigma^2)-1)*exp(2*mu+sigma^2);
deviation=sqrt(deviation);
