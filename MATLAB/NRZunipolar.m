%NRZ Unipolar signal
bk = rand(1,20)>0.5; %[1 1 0 1 1 0 0 0 0 0 0 0 0 1];
N = length(bk);
t = 0:1/200:(N-1/200);
st = [];
for k=1:N
    if(bk(k)==1) st = [st ones(1,200)];
    else st = [st zeros(1,200)];
    end
end
figure(1)
plot(t,st); 
axis([0 N -.5 1.5]);
title('NRZ uniplar');
xlabel('time');