%Basics of telecommunications
% demostration of gray code which reduces bit error rate in a communication
% system.
clear all
Ns = 10;        % number of symbols in one simulation
M = 4;          % number of levels of encoding scheme
L = log2(M);    % number of bits in a symbol
SNR = 10;       % signal to noise ratio, in decibels
n = L*Ns;       % number of bits total
ts = 50;        % time resolution
t=0:1/ts:(Ns-1/ts); % time line
LOOP = 100;     % loop times
pErr = 0;       % error counter for plain coding
gErr = 0;       % error counter for gray coding
for n=1:LOOP
    for k=1:L       % generate random bits (LxNs)
        bks(k,:) = rand(1,Ns)>0.5;
    end
    % make plain encoding signal
    noise = wgn(1,length(t),-10);
    plain = 2*bks(1,:) + bks(2,:) - 1.5;
    plainsignal = kron(plain, ones(1,ts));
    rplain = plainsignal + noise;
    figure(1)
    subplot(2,1,1);
    plot(t, plainsignal, 'r', t, rplain, 'g');
    axis([0 Ns -2.5 2.5]);
    for k=1:Ns
        text((k-1)+0.5, 2, sprintf('%d%d', bks(1,k),bks(2,k)));
    end
    % receiver for plain code:
    ps = rplain(ts/2:ts:end);   % take samples
    rp = zeros(L,Ns);           % prepare for received detection result
    for k=1:Ns  % go through all the samples
        if(ps(k)<-1) rp(:,k)=[0; 0];
        elseif(ps(k)>=-1 && ps(k)<0) rp(:,k)=[0; 1];
        elseif(ps(k)>=0 && ps(k)<1) rp(:,k)= [1; 0];
        else rp(:,k)=[1; 1];
        end
    end
    % calculate BER
    perrors = sum(sum(rp~=bks));
    pErr = pErr + perrors;      % accumulate the error counter
    
    % make gray code signal
    gks(1,:)=bks(1,:); % copy the MSB of binary to MSB of gray
    for k=2:L
        gks(k,:)=xor(bks(k-1,:),bks(k,:)); %xor the rest
    end
    gray = 2*gks(1,:) + gks(2,:) -1.5;  % generate multilevel signal
    graysignal = kron(gray, ones(1,ts));    % extern signal on time
    rgray = graysignal + noise;
    subplot(2,1,2)
    plot(t,graysignal, 'r', t, rgray, 'g');
    axis([0 Ns -2.5 2.5]);
    % receiver for gray code
    gs = rgray(ts/2:ts:end);
    rg = zeros(L,Ns);
    for k=1:Ns  % go through all the samples
        if(gs(k)<-1) rg(:,k)=[0; 0];
        elseif(gs(k)>=-1 && gs(k)<0) rg(:,k)=[0; 1];
        elseif(gs(k)>=0 && gs(k)<1) rg(:,k)= [1; 0];
        else rg(:,k)=[1; 1];
        end
    end
    % convert back to binary
    rb(1,:)=rg(1,:);
    for k=2:L
        rb(k,:) = xor(rg(k,:),rb(k-1,:));
    end
    gerrors = sum(sum(rb~=bks));
    gErr = gErr + gerrors;
    pause(0.1);
end