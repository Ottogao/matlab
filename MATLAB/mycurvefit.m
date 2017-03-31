clf
clear all
DC = [0;1;2;4;6;7;8;10;20;30;40;50;60;70;80;90;100];
Factor = [0.0001;0.0166;0.1857;0.4352;0.5821;0.6326;0.6749;0.7540;0.8753;0.9216;0.9446;0.9612;0.9723;0.9819;0.9897;0.9957;1];

figure(1)
plot(log(DC), Factor);
box on
grid on

figure(2)
plot(DC, log(DC+1))
normDC = DC/max(DC);
FDC = log(1+50*normDC)/log(1+50);
A=100;
AFDC = A*normDC/(1+log(A)).*(normDC<1/A) + (1+log(A*normDC))/(1+log(A)).*(normDC>=1/A);
figure(3)
plot(normDC, FDC, 'r', normDC, Factor, 'b', normDC, AFDC, 'm');

c = polyfit(log(DC+1),Factor, 2);

figure(4)
plot(Factor, exp( (-c(2)-sqrt(c(2)^2-4*c(1)*(c(3)-normDC)))/(2*c(1))))
%%plot(Factor,exp((Factor-0.515)/0.23))