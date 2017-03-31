function exam9_1

% Example 9.1: Optimal weight vector 

clear
clc
fprintf('Example 9.1: Optimal weight vector\n\n')
m = 1;
N = f_prompt ('Enter period of input',3,32,4);
psi = 2*pi/N
D = 0.5;

% Compute cross-correlation vector and auto-correlation matrix

p = [0 ; sin(psi)]
R = 2*[1, cos(psi) ; cos(psi), 1]
lambda = eig(R)

% Find optimal weight vector

w_hat = R \ p
rho_min = D - 2*w_hat'*p + w_hat'*R*w_hat

% Compute mean square error surface

dw = 4;
n = 51;
rho = zeros(n,n);
x = linspace (-dw,dw,n);
y = x;
w = zeros(m+1,1);
for i = 1 : n
   for j = 1 : n
       w = [x(i) ; y(j)];
       rho(j,i) = D - 2*w'*p + w'*R*w;
   end
end

% Plot it

figure
surf (x,y,rho)
pause(0.01)               % needed to get clean plot?
surf (x,y,rho)
f_labels ('Mean square error','\it{w_0}','\it{w_1}','\it{\epsilon(w)}')
f_wait
