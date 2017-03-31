function exam9_11

% Example 9.11: FIR filter design 

clear
clc
fprintf('Example 9.11: FIR filter design\n\n')
N = f_prompt ('Enter number of discrete frequencies',2,200,60);
m = f_prompt ('Enter filter order m',0,2*N,N/2);
mu = f_prompt ('Enter LMS step size mu',0,1,.0001);
M = f_prompt ('Enter number of iterations M',1,4000,2000);

% Construct specifications

fs = 1;
T = 1/fs;
f = linspace(0,(N-1)*fs/(2*N),N);
C = ones(1,N);
A = mag_fun(f,fs);
phi = zeros(size(f));

% Construct input and desired output

x = zeros(M,1);
d = zeros(M,1);
for k = 0 : M-1
    x(k+1) = sum(C .* sin(2*pi*f*k*T));
    d(k+1) = sum(A .* C .* sin(2*pi*f*k*T + phi));
end

% Find optimal weights

[w,e] = f_lms (x,d,m,mu);

% Compute frequency response

b = w;
a = 1;
r = N;
[H,freq] = f_freqz(b,a,r,fs);
A_FIR = abs(H);
phi_FIR = unwrap(angle(H));

% Plot frequency responses

figure
subplot(2,1,1)
hp = plot (f,A,'.',freq,A_FIR);
set (hp(2),'LineWidth',1.5)
legend ('Pseudofilter','FIR filter')
axis([0 0.5 0  2])
f_labels ('','\it{f/f_s}','\it{A(f)}')
subplot (2,1,2)
hp = plot (f,phi,'.',freq,phi_FIR);
set (hp(2),'LineWidth',1.5)
axis ([0 0.5 -1 1])
legend ('Pseudofilter','FIR filter',2)
f_labels ('','\it{f/f_s}','\it{\phi(f)}')
f_wait

% Adjust phase and find optimal weights

phi = phase_fun (f,fs,m);
for k = 0 : M-1
    d(k+1) = sum(A .* C .* sin(2*pi*f*k*T + phi));
end
[w,e] = f_lms (x,d,m,mu);

% Compute frequency response

b = w;
a = 1;
r = N;
[H,freq] = f_freqz(b,a,r,fs);
A_FIR = abs(H);
phi_FIR = unwrap(angle(H));

% Plot frequency responses

figure
subplot(2,1,1)
hp = plot (f,A,'.',freq,A_FIR);
set (hp(2),'LineWidth',1.5);
legend ('Pseudofilter','FIR filter')
axis ([0 0.5 0 2])
f_labels ('','\it{f/f_s}','\it{A(f)}')
subplot (2,1,2)
hp = plot (f,phi,'.',freq,phi_FIR);
set (hp(2),'LineWidth',1.5);
legend ('Pseudofilter','FIR filter')
f_labels ('','\it{f/f_s}','\it{\phi(f)}')
f_wait

% Subfunctions

function A = mag_fun (f,fs)
dA = 0.5;
N = length(f);
for i = 1 : N
    if f(i) <= fs/6
        A(i) =  dA + 1 - f(i) / (fs/6);
    elseif (f(i) > fs/6) & (f(i) < fs/3)
        A(i) = dA;
    else
        A(i) = dA + 0.5*sin(pi*(f(i)-fs/3)/(fs/6));
    end
end

function phi = phase_fun (f,fs,m)
phi = -m*pi*f/fs;
 
