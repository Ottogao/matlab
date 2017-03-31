%This function generates burst traffic for each node

function Packets=save_packet(Packets,users,burst_packet_size);

% load parameters
id=Packets(:,1);
s_time=Packets(:,2);
e_time=Packets(:,3);
r_size=Packets(:,4);
n_id=Packets(:,5);
delay=Packets(:,6);

global new_b_packet
packet_index=find(new_b_packet~=0)';           %find all the nodes which have burst traffic
amount=size(packet_index,1);
p_amount=new_b_packet(packet_index);
 global TIME                            %get current time
    temp=TIME;
    
if amount==0                            %if no new burst packet generated
   
else
     for k=1:amount                 
         if id(1)==0
            id=[1:p_amount(k)]';
            s_time=temp(ones(p_amount(k),1));
            e_time=zeros(p_amount(k),1);
            r_size=burst_packet_size(ones(p_amount(k),1));
            n_id=packet_index(k)*(ones(p_amount(k),1));
            delay=zeros(p_amount(k),1);
         else
            id(end+1:end+p_amount(k),1)=[id(end)+1:id(end)+p_amount(k)]';
            s_time(end+1:end+p_amount(k),1)=temp(ones(p_amount(k),1));
            e_time(end+1:end+p_amount(k),1)=zeros(p_amount(k),1);
            r_size(end+1:end+p_amount(k),1)=burst_packet_size(ones(p_amount(k),1));
            n_id(end+1:end+p_amount(k),1)=packet_index(k)*(ones(p_amount(k),1));
            delay(end+1:end+p_amount(k),1)=zeros(p_amount(k),1);
         end                 
     end 
end
 %save data
    Packets=[id s_time e_time r_size n_id delay];
 


