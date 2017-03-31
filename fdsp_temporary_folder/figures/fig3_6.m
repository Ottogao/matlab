function fig3_6

% FIGURE 3.6:  DFT symmetry property 

clear
clc
fprintf('Figure 3.6: DFT symmetry property\n\n')
N = f_prompt('Enter number of samples',2,2048,256);

% Construct x(k) and compute X(k)

fs = 2*N;
k = 1 : N;
x = .8.^k - (-.9).^k;
[A,phi,S,f] = f_spec (x,N,fs);
k(N+1) = N+1;
A(N+1) = A(1);
phi(N+1) = phi(1);
 
% Plot mangitude and phase spectra
 
figure
subplot(2,1,1)
plot(k-1,A,'LineWidth',1.5)
hold on
fn = [N/2,N/2];
plot (fn,[0,10],'k')
set (gca,'Xlim',[0 N]);
set (gca,'Xtick',[0 64 128 192 256])
f_labels ('Magnitude spectrum','\it{i}','|{\itX(i)}|');
subplot(2,1,2)
plot(k-1,phi,'LineWidth',1.5);
hold on
plot (fn,[-1,1],'k')
set (gca,'Xlim',[0 N])
set (gca,'Xtick',[0 64 128 192 256])
f_labels ('Phase spectrum','\it{i}','{\it\phi(i)}');
f_wait
