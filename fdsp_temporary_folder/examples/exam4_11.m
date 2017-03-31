function exam4_11

% EXAMPLE 4.11: Estimation of period using auto-correlation

clear
clc
fprintf('Example 4.11: Estimation of period using auto-correlation\n')
rand('state',000)

% Construct signals x and y

N = 256;
k = 0 : N-1;
x = cos(32*pi*k/N) + sin(48*pi*k/N);
a = 0.5;
y = f_randu(1,N,-a,a) + x;
figure 
plot (k,y)
f_labels ('A noisy periodic signal','\it{k}','\it{y(k)}')
f_wait

% Compute auto-correlation

r_yy = f_corr(y,y,1,0);
figure 
plot (k,r_yy)
f_labels ('Mark two consequtive peak points with mouse cross hairs!','\it{k}','\it{r_{yy}(k)}')
[x1,y1] = f_caliper(2);
period = x1(2) - x1(1)
rounded_period = round(period)
f_wait
