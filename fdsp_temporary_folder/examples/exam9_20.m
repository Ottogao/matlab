function exam9_20

% Example 9.20: Identification of a chemical process 

clear
clc
fprintf('Example 9.20: Identification of a chemical process\n\n')
tau = 5
T = 0.5
M = tau/T
p = 0.2;
c = 4;
N = 1000;
rand ('seed',1000)
m = f_prompt ('Enter adaptive filter order',0,80,40);
alpha = f_prompt ('Enter normalized step length',0,1,0.1);

% Compute the coefficients of the IIR model 

a = [1+p*T, -1];
b = [zeros(1,M) c*T];

% Compute the input and desired output

x = f_randu (N,1,-1,1);
d = filter (b,a,x);

% Identify a model using normalized LMS method

[w,e] = f_normlms (x,d,m,alpha);

% Learning curve

figure
k = 0 : N-1;
stem (k,e.^2,'filled','.')
f_labels ('Learning curve','\it{k}','\it{e^2(k)}')
f_wait

% Compare responses to new input

P = 200;
x = f_randu (P,1,-1,1);
d = filter (b,a,x);
y = filter (w,1,x);
figure
k = 0 : P-1;
hp = plot (k,d,k,y);
set (hp(1),'LineWidth',1.5)
legend ('\it{d(k)}','\it{y(k)}')
e = d - y;
E = sum(e.^2)/sum(d.^2)
caption = sprintf ('Comparison of outputs, {\\itE} = %.4f',E);
f_labels (caption,'\it{k}','Outputs')
f_wait
