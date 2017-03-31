%AMI & HDB3 encoder
clf
clear all
N = 20;
hdb3pattern1 = [1 0 0 1];       % scrambling pattern 1
hdb3pattern2 = [0 0 0 1];       % scrambling pattern 2
% binary = rand(1,N)>0.5;       % generate random binary
binary = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0]; % or generate this binary stream for testing
% first generate AMI code
mark = 0;       % initialize the mark
for k=1:N       % go through all the bits
    if(binary(k)==0) ami(k)=0;
    else
        if(mark==0)
            ami(k) = 1; mark = 1;
        else
            ami(k) = -1; mark = 0;
        end
    end
end
k = 1;
hdb3 = zeros(1,N);
prepole = -1;       % initialize the previous pole, for the next one to be positive
while(k<=N-4)
    if(ami(k)==0 & ami(k+1)==0 & ami(k+2)==0 & ami(k+3)==0)     % for 4 consecutive zeros
        if(mod(sum(hdb3(1:k)),2)==0)  % if the previous pulses are evenly balanced
            if(prepole == -1)           % if the previous pole is negative
                hdb3(k:k+3) = hdb3pattern1;
                prepole = 1;
            else        % if the previous pole is positive
                hdb3(k:k+3) = -hdb3pattern1;
                prepole = -1;
            end     % end of pole checking
        else     % if the previous pulses are oddly balanced
            if(prepole == 1)
                hdb3(k:k+3) = hdb3pattern2;
            else
                hdb3(k:k+3) = -hdb3pattern2;
            end
        end
        k=k+4;
    else
        if(ami(k)~=0) 
            hdb3(k) = -prepole;
            prepole = hdb3(k);
        else
            hdb3(k)=ami(k);
        end
        k=k+1;
    end
end
tr = 100;
t = linspace(0,N,tr*N);         % make a timeline
bt = kron(binary, ones(1,tr));  % extend all the signals in time
amit = kron(ami, ones(1,tr));
hdb3t = kron(hdb3, ones(1,tr));
figure(1)
plot(t,bt+1, t, 0.5*amit,'r',t,0.5*hdb3t-1.5,'m');
legend('binary','AMI','HDB3','location','southeast');
set(gca,'XTick',[0:N])
set(gca,'XGrid','on');
axis([0 N -2.5 2.5]);
for k=1:N
    text(k-0.5,2.1,sprintf('%d',binary(k)));
end