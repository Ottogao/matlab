clf
clear all
p=0.000005;    %BER
L=10:10:1000000;
F = 1-(1-p).^L;
subplot(2,1,1);
plot(L,F);
xlabel('Frame Length in bits')
ylabel('FER');
th = L.*((1-p).^L);
subplot(2,1,2)
plot(L,th,'m');
xlabel('Frame Length in bits');
ylabel('Normalized throughput');
[maxT maxI] = max(th);
hold on
plot([maxI*10 maxI*10],[0 maxT]);
text(maxI*10,maxT,sprintf('max TH w/ L*=%d',maxI))
