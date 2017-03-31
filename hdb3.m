%hdb3.m - made by Chao Gao 20.11.2014
N = 32; % number of bits
bn = rand(1,N)>0.8; 
bn=[1 0 1 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 1 0 1 1];
% bn = [1 1 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 0 ];
N = length(bn);
ami = zeros(1,N);
% convert to AMI
bal = 1;
for k=1:length(bn)
    if bn(k)==1
        ami(k) = bal;
        bal = -bal;
    end
end

hdb_3 = zeros(1,N);
%convert to hdb3
bal = 1;    % balance
pc = 1;     % number of pulses since last substitution (default is 1 to make 000V)
k = 1;
while k<=length(bn)-3   
    if(sum(bn(k:k+3))==0)    % for the case there are 4 consective zeros
        if mod(pc,2)==1
            hdb_3(k:k+3) = [0 0 0 -bal];
        else
            hdb_3(k:k+3) = [bal 0 0 bal];
            bal = -bal;
        end
        pc = 0; % reset pc
        k = k + 4;  % skip over 4 pulses
        if k>length(bn)
            break;
        end
    elseif bn(k)==1     % for a normal 1
        hdb_3(k) = bal; % use current polarity
        bal = -bal;     % reverse polarity
        pc = pc +1;     % pc increases
        k = k+1;
    else
        k = k+1;
    end
end
while k<=length(bn)
    if bn(k)==1
        hdb_3(k) = bal;
        bal = -bal;
    end
    k = k+1;
end

figure(1)
subplot(3,1,1); 
stairs(0:N-1, bn); axis([0 N -2 2]); grid on
subplot(3,1,2);
stairs(0:N-1, ami); axis([0 N -2 2]); grid on
subplot(3,1,3);
stairs(0:N-1, hdb_3); axis([0 N -2 2]); grid on;
for k=1:length(bn)
    text(k-0.5, 1.5, int2str(bn(k)));
end