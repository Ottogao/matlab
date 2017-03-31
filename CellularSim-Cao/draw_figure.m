function draw_figure(users,CBRs,packets_finnished,Average_delay,BS_utilization,simu_time)
global TOTAL_EVANT TOTAL_DROP TOTAL_HANDOVER HANDOVER_DROP
s_time_fin=packets_finnished(:,4);
delay_fin=packets_finnished(:,3);

X=[1:size(CBRs,1)];
Y1=sort(CBRs(:,4))';
Y2=sum(CBRs(:,4))/size(CBRs,1)*(ones(1,size(CBRs,1)));
figure(2);
plot(X,Y1,'-r*',X,Y2,'-b');
xlabel('Index of CBRs');
ylabel('Percentage');
title('CBR Satisfaction Figure');
legend('CBR Satisfied Percentage','Average Satisfied Percentage',2);
axis([0,inf,0,1.2]);

Y=[TOTAL_EVANT TOTAL_DROP TOTAL_HANDOVER HANDOVER_DROP;0 0 0 0;];
figure(3);
bar(Y,'group');
title('Handover and Blocked Frequency');
ylabel('Number of Events');
grid on;

%temp_size=size(packets_finnished,1);
delay_time=zeros(1,simu_time);
for n=1:simu_time
    temp_index=find(round(s_time_fin)==n);
    temp_amount=size(temp_index,1);
    if temp_amount~=0
        delay_time(n)=sum(delay_fin(temp_index))/temp_amount;
    end
end

if Average_delay~=0
    X=[1:simu_time];
    %Y=packets_finnished(2:end,3);
    Y=delay_time;
    figure(4);
    average=Average_delay*ones(simu_time,1);
    plot(X,Y,'-b*',X,average,'-r');
    legend('Delay in t second','Average Delay',2);
    xlabel('Arriving time of Packets(sec)');
    ylabel('Delay(sec)');
    title('Burst Packets Delay');
    grid on;
end


figure(5);
Y=zeros(1,7);
for k=1:7
    Y(k)=sum(BS_utilization(:,k))/simu_time;
end
bar(Y);
grid on;
title('Base Station Utility');
xlabel('Base Stationm Number');
ylabel('Utility');

figure(6);
X=[1:simu_time];
Y=zeros(simu_time,1);
for k=1:simu_time
    Y(k)=sum(BS_utilization(k,:))/7;
end
for k=1:7
    subplot(3,3,k);
    plot(X,BS_utilization(:,k),X,Y);
    a='Base Station';
    b=num2str(k);
    title(strcat(a,b));
    grid on;
    xlabel('Time(sec)');
    ylabel('Utility');
    axis([0,inf,0,1.1]);
end
%legend('Base Station n','Average Utility of 7 BS',0);


