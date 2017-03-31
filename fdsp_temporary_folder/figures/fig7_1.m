function fig7_1

% Figure 7.1: A filter bank of narrowband bilters

clc
clear
fprintf ('Figure 7.1: A filter bank of narrowband filters\n\n')
fs = 1;
N = f_prompt ('Enter number of filters in bank',1,10,6);
dF = fs/N;
F = [0 : dF : fs]
B_tran = dF/10
B_pass = dF - B_tran
p = 1001;

% Compute magnitude responses

A = zeros(p,N+1);
f = linspace (0,fs,p);
for j = 1 : N+1
    for i = 1 : p
        df1 = f(i) - (F(j) - B_pass/2 - B_tran);
        if (df1 >= 0) & (df1 < B_tran)
            A(i,j) = df1/B_tran;
        end
        df2 = f(i) - F(j);
        if (df2 >= -B_pass/2) & (df2 <= B_pass/2);
            A(i,j) = 1;
        end
        df3 = f(i) - (F(j) + B_pass/2);
        if (df3 > 0) & (df3 <=B_tran)
            A(i,j) = 1 - df3/B_tran;
        end
    end
end

% Plot them

figure
hold on
box on
for i = 1 : N+1
    plot (f,A(:,i),'LineWidth',1.5)
end
axis ([0 fs -0.5 1.5])
f_labels ('A filter bank','\it{f/f_s}','\it{A(f)}')

% Add sum plus shading

for i = 1 : N
    x(1) = F(i) + B_pass/2;
    x(2) = x(1) + B_tran;
    x(3) = (x(1) + x(2))/2;
    y = [0 0 0.5];
    fill (x,y,'c')
end
f_wait
