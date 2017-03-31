function exam9_7

% Example 9.7: Excess mean square error 

clear
clc
fprintf('Example 9.7: Excess mean square error\n\n')
rand('seed',1000)
m = 1;
r = f_prompt ('Enter number of samples',1,1000,250);
c = f_prompt ('Enter magnitude of noise',0,1,.5);
N = f_prompt ('Enter period of x',1,16,4);

% Construct input and desired output

k = [0 : r-1]';
v = f_randu(r,1,-c,c);
x = 2*cos(2*pi*k/N) + v;
d = sin(2*pi*k/N);

% Compute step size

P_x = 2 + c^2/3
mu_max = 1/((m+1)*P_x)
mu = [.1 .01];

% Compute error for different step sizes

figure
for i = 1 : 2
    w = zeros(m+1,1);
    [w,e] = f_lms (x,d,m,mu(i));    
    subplot (2,1,i);
    plot (k,e.^2);
    if i == 1
        f_labels ('Excess Mean Square Error','k','e^2(k)')
    else
        f_labels ('','k','e^2(k)')
    end        
    
    key = sprintf ('\\mu = %.2f',mu(i));
    text (.45*r,0.5,key)
end
f_wait
