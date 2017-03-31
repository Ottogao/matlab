% demonstration of gray code vs plain code in 2B1Q encoding scheme
clear all
clf
N=20;       % number of bits generated
Ns=N/2;     % number of symbols in one run
RE = 100;   % repeat times
ts = 100;   % timeline resolution
t = 0:(1/ts):(Ns-1/ts); % generate timeline
erracc = 0;     % accumulate errors
errgray = 0;    % accumulate gray code errors
for n=1:RE
    bk = rand(1,N)>0.5; % generate random bits
    bk1 = bk(1:2:N);    % regroup the bits as first/second pattern
    bk2 = bk(2:2:N);
    qlvl = bk1*2 + bk2 - 1.5;       % generate linear levels
    st = kron(qlvl, ones(1,ts));    % extend the binary to signals
    figure(1)
    subplot(2,1,1)
    plot(t,st)          % plot the linear 2B1Q signal
    axis([0 Ns -3 3]);
    noise = 0.2*randn(1,length(t)); % generate noise
    rt = st + noise;    % received signal
    subplot(2,1,2)      % plot it
    plot(t,rt);
    axis([0 Ns -3 3]);

% linear 2B1Q receiver detection
    rk = rt(ts/2:ts:length(t)); % sample at middle of each symbol
    for k=1:Ns
        if(rk(k)>1)
            rb((2*k-1):2*k)=[1 1];
        end
        if(rk(k)<=1 && rk(k)>0)
            rb((2*k-1):2*k)=[1 0];
        end
        if(rk(k)<=0 && rk(k)>-1)
            rb((2*k-1):2*k)=[0 1];
        end
        if(rk(k)<=-1)
            rb((2*k-1):2*k)=[0 0];
        end
    end
    error = sum(bk~=rb);        % find the number of erroneous bits
    erracc = erracc + error;    % accumulate the number

    % now for gray code, for 2-bit gray codes are 00, 01, 11, 10
    % respectively
    gk1 = bk1;                  % copy MSB
    gk2 = xor(bk1,bk2);         % the LSB is XOR of first and second bits
    glvl = gk1*2 + gk2 - 1.5;   % gray code levels
    gt = kron(glvl, ones(1,ts));    % extend discrete values as a signal
    figure(2)
    subplot(2,1,1);     % plot the signal
    plot(t, gt)
    axis([0 Ns -3 3]);
    grt = gt + noise;   % add the same noise
    subplot(2,1,2);
    plot(t, grt);       % plot the received signal
    axis([0 Ns -3 3]);    
    rgk = grt(ts/2:ts:length(t)); % sample at middle of each symbol
    for k=1:Ns          % detect the bits according to levels
        if(rgk(k)>1)
            rgb((2*k-1):2*k)=[1 1];
        end
        if(rgk(k)<=1 && rgk(k)>0)
            rgb((2*k-1):2*k)=[1 0];
        end
        if(rgk(k)<=0 && rgk(k)>-1)
            rgb((2*k-1):2*k)=[0 1];
        end
        if(rgk(k)<=-1)
            rgb((2*k-1):2*k)=[0 0];
        end
    end
    rgb1 = rgb(1:2:N);  % MSB of the received gray code
    rgb2 = rgb(2:2:N);  % LSB
    gb1 = rgb1;         % copy MSB of gray as MSB of binary
    gb2 = xor(gb1,rgb2);   % XOR the next gray bit with first binary bit
    gb = reshape([gb1; gb2], 1, N); % re-organize the bits as one vector
    error = sum(bk~=gb);    % check errors
    errgray = errgray + error; % accumulate the errors
    pause(0.1)    
end
msglinear = sprintf('BER = %f', erracc/N/RE);
msggray = sprintf('BER = %f', errgray/N/RE);
figure(1)
title(msglinear);
figure(2)
title(msggray);