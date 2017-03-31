function exam9_19

% Example 9.19: Discrete-time nonlinear model 

clear
clc
fprintf('Example 9.19: Discrete-time nonlinear mmodel\n\n')
a = [0,1]
m = 2;
n = 2;
d = 5;
p = m+n+1
r = d^p
N = 100;
P = 1000;
theta = zeros(p,1);
rand('seed',100);

% Estimate output bounds

x = f_randu(P,1,a(1),a(2));
y = zeros(size(x));
for k = 1 : P
    theta = f_state (x,y,k,m,n);
    y(k) = van_de_vusse (theta);
end
y_min = min(y);
y_max = max(y);
beta = 1.5                            % safety factor
b(1) = (y_min + y_max)/2 - beta*(y_max - y_min)/2;
b(2) = (y_min + y_max)/2 + beta*(y_max - y_min)/2;
b
Delta_x = (a(2)-a(1))/(d-1)
Delta_y = (b(2)-b(1))/(d-1) 

% Compute weights

w = f_rbfw (@van_de_vusse,0,a,b,m,n,d,0,1);

% Compute outputs

x = f_randu (N,1,a(1),a(2));
y_0 = f_rbf0 (x,w,a,b,m,n,d);
y = zeros(N,1);
for k = 1 : N
    theta = f_state (x,y,k,m,n);
    y(k) = van_de_vusse (theta,m,n);
end

% Compare them

figure;
k = 0 : N-1;
hold on
hp = plot (k,y,k,y_0);
set (hp(1),'LineWidth',1.5)
caption = 'Outputs of system {\itS_f} and RBF model {\itS_0}';
f_labels (caption,'\it{k}','Outputs')
legend ('\it{y(k)}','\it{y_0(k)}')

axis ([0 N 0.2 1.4])
for i = 1 : d
    y_g = b(1) + (i-1)*Delta_y;
    if (i > 1) & (i < d)
       plot ([0 N-1],[y_g y_g],'k:')
   else
       plot ([0 N-1],[y_g y_g],'k')
   end
end
box on
f_wait

% Compute normalized mean square error

e = y - y_0;
E = sum(e.^2)/sum(y.^2)

function y = van_de_vusse (theta,m,n)

% Description: Van de Vussse reaction in continuout stirred tank reactor
%              m=2,n=2.

c = [0.558, 0.538,0.116,-0.127,-0.034];
y = c(1) + c(2)*theta(2) + c(3)*theta(4) + c(4)*(theta(2)^3) + ...
    c(5)*theta(5)*theta(3)*theta(2);
