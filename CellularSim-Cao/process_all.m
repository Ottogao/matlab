%This function is to allocation spreading code to nodes and send packet

function [nodes,Packets,CBRs,BS_utilization,packets_finnished]=process_all(packets_finnished,BS_utilization,CBRs,users,Packets,Cell_Num,N,available_sf,ts_number,min_data_rate,minimum_cbr_rate,t,simu_time)

% load data of users
x_pos=users(:,1);              
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
offsite=users(:,3:4);
traffic=zeros(N*Cell_Num,8);
traf_type=users(:,10);
traf_dur=users(:,11);
data_rate=users(:,12);
sf=users(:,13);
remained_time=users(:,14);
is_servered=users(:,15);
is_handover=users(:,16);
real_sf=users(:,17);
in_cell = users(:,5);          
v = users(:,6);                 
dir = users(:,7);
burst=zeros(N*Cell_Num,2);
b_sf=users(:,18);
b_size=users(:,19);              
%load data of Packets
id=Packets(:,1);
s_time=Packets(:,2);
e_time=Packets(:,3);
r_size=Packets(:,4);
n_id=Packets(:,5);
delay=Packets(:,6);
%load data of CBRs
cbr_id=CBRs(:,1);
cbr_time_dif=CBRs(:,2);
cbr_n_id=CBRs(:,3);
cbr_percent=CBRs(:,4);
U=zeros(simu_time,7);
p_id_fin=packets_finnished(:,1);
n_id_fin=packets_finnished(:,2);
delay_fin=packets_finnished(:,3);
s_time_fin=packets_finnished(:,4);
 global HANDOVER_DROP TOTAL_DROP TIME
for k=1:7
    U(:,k)=BS_utilization(:,k);
end

for k=1:7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
    cell_k_totalserve_index=find(in_cell==(k-1) & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 0 which are fully served and not a handover
    
    for n=1:size( cell_k_totalserve_index,1)
        if remained_time(cell_k_totalserve_index(n))<=0
            traf_type(cell_k_totalserve_index(n))=0;
            sf(cell_k_totalserve_index(n))=0;
            real_sf(cell_k_totalserve_index(n))=0;
            traf_dur(cell_k_totalserve_index(n))=0;
            data_rate(cell_k_totalserve_index(n))=0;
            is_servered(cell_k_totalserve_index(n))=0;
        else
            cbr_temp_index=find(cbr_n_id== cell_k_totalserve_index(n),1,'last');             %find cbr traffic corresponding to the current node in CBRs array           
    
            remained_time(cell_k_totalserve_index(n))= remained_time( cell_k_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
    
            cbr_time_dif(cbr_temp_index)=(traf_dur( cell_k_totalserve_index(n))- remained_time( cell_k_totalserve_index(n)))*ts_number;   %calculate how many time slot had pasted
            cbr_percent(cbr_temp_index)=(cbr_percent(cbr_temp_index)*(cbr_time_dif(cbr_temp_index)-1)+real_sf(cell_k_totalserve_index(n))/sf(cell_k_totalserve_index(n)))/cbr_time_dif(cbr_temp_index);  %calculate average satified percentaga
        end      
    end
    c_available_sf=available_sf-sum(real_sf( cell_k_totalserve_index));        %calculate the number of spreading codes have been used and reduce them.

    cell_k_halfserve_index=find(in_cell==(k-1) & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 0 which do not reach the quality of service    
    for n=1:size(cell_k_halfserve_index,1)
        if remained_time(cell_k_halfserve_index(n))<=0
            traf_type(cell_k_halfserve_index(n))=0;
            sf(cell_k_halfserve_index(n))=0;
            real_sf(cell_k_halfserve_index(n))=0;
            traf_dur(cell_k_halfserve_index(n))=0;
            data_rate(cell_k_halfserve_index(n))=0;
            is_servered(cell_k_halfserve_index(n))=0;
        else
            cbr_temp_index=find(cbr_n_id==cell_k_halfserve_index(n),1,'last');             %find cbr traffic corresponding to the current node in CBRs array    
            if c_available_sf>=sf(cell_k_halfserve_index(n))    %if there are enough spread codes for it
                real_sf(cell_k_halfserve_index(n))=sf(cell_k_halfserve_index(n));  %this node will reach the quality of service               
            end  
            c_available_sf=c_available_sf-real_sf(cell_k_halfserve_index(n));    %calculate the number of spreading codes have been used and reduce them.    
                    
            remained_time(cell_k_halfserve_index(n))= remained_time(cell_k_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot
    
            cbr_time_dif(cbr_temp_index)=(traf_dur(cell_k_halfserve_index(n))- remained_time(cell_k_halfserve_index(n)))*ts_number;   %calculate how many milliseconds had pasted
            cbr_percent(cbr_temp_index)=(cbr_percent(cbr_temp_index)*(cbr_time_dif(cbr_temp_index)-1)+real_sf(cell_k_halfserve_index(n))/sf(cell_k_halfserve_index(n)))/cbr_time_dif(cbr_temp_index);  %calculate average satified percentage
        end    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
    cell_k_handover_index=find(in_cell==(k-1) & traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 0 which is generating taffic and has made a handover
    for n=1:size(cell_k_handover_index,1)                                 %go through all this kind of nodes
        if remained_time(cell_k_handover_index(n))<=0
            traf_type(cell_k_handover_index(n))=0;
            sf(cell_k_handover_index(n))=0;
            real_sf(cell_k_handover_index(n))=0;
            traf_dur(cell_k_handover_index(n))=0;
            data_rate(cell_k_handover_index(n))=0;
            is_servered(cell_k_handover_index(n))=0;
        else
            cbr_temp_index=find(cbr_n_id==cell_k_handover_index(n),1,'last');             %find cbr traffic corresponding to the current node in CBRs array   
            if  c_available_sf>=sf(cell_k_handover_index(n))               %if there are enough spreading codes for it
                real_sf(cell_k_handover_index(n))=sf(cell_k_handover_index(n));
                is_servered(cell_k_handover_index(n))=1;                 %this node can be servered
                is_handover(cell_k_handover_index(n))=0;
                c_available_sf=c_available_sf-real_sf(cell_k_handover_index(n));      %spreading codes have been used  
                remained_time(cell_k_handover_index(n))=remained_time(cell_k_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot        
               
                cbr_time_dif(cbr_temp_index)=(traf_dur(cell_k_handover_index(n))- remained_time(cell_k_handover_index(n)))*ts_number;   %calculate how many milliseconds had pasted
                cbr_percent(cbr_temp_index)=(cbr_percent(cbr_temp_index)*(cbr_time_dif(cbr_temp_index)-1)+real_sf(cell_k_handover_index(n))/sf(cell_k_handover_index(n)))/cbr_time_dif(cbr_temp_index);  %calculate average satified percentage
            else                                                           % if spreading codes is not enough
                if c_available_sf<minimum_cbr_rate*sf(cell_k_handover_index(n))          %a failed handover call
                    real_sf(cell_k_handover_index(n))=0;
                    traf_type(cell_k_handover_index(n))=0; 
                    sf(cell_k_handover_index(n))=0;
                    traf_dur(cell_k_handover_index(n))=0;
                    data_rate(cell_k_handover_index(n))=0;
                    is_servered(cell_k_handover_index(n))=0;
                    remained_time(cell_k_handover_index(n))=0;
                    is_handover(cell_k_handover_index(n))=0;
                             
                    cbr_time_dif(cbr_temp_index)=0;                 %indicate this traffic is failed
                    cbr_percent(cbr_temp_index)=0;                  %calculate average satified percentage 
                                        
                    HANDOVER_DROP=HANDOVER_DROP+1;     %calculate failed handover calls
                    TOTAL_DROP=TOTAL_DROP+1;
                else
                    real_sf(cell_k_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
                    is_servered(cell_k_handover_index(n))=1;                 %this node can be servered
                    is_handover(cell_k_handover_index(n))=0;
                    c_available_sf=c_available_sf-real_sf(cell_k_handover_index(n));      %spreading codes have been used 
                    remained_time(cell_k_handover_index(n))=remained_time(cell_k_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
                               
                    cbr_time_dif(cbr_temp_index)=(traf_dur(cell_k_handover_index(n))- remained_time(cell_k_handover_index(n)))*ts_number;   %calculate how many milliseconds had pasted
                    cbr_percent(cbr_temp_index)=(cbr_percent(cbr_temp_index)*(cbr_time_dif(cbr_temp_index)-1)+real_sf(cell_k_handover_index(n))/sf(cell_k_handover_index(n)))/cbr_time_dif(cbr_temp_index);  %calculate average satified percentage
                end                                              
            end
        end       
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
    cell_k_new_index=find(in_cell==(k-1) & traf_type~=0 & is_servered==0);   %find all nodes in cell 0 which is generating new traffic
    for n=1:size(cell_k_new_index,1)                                    %go through all this kind of nodes
        cbr_temp_index=find(cbr_n_id==cell_k_new_index(n),1,'last');             %find cbr traffic corresponding to the current node in CBRs array
    
        if c_available_sf>=sf(cell_k_new_index(n))                       %if there are enough spreading codes for it
            real_sf(cell_k_new_index(n))=sf(cell_k_new_index(n));       
            is_servered(cell_k_new_index(n))=1;                         %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_k_new_index(n));      %spreading codes have been used   
            remained_time(cell_k_new_index(n))=remained_time(cell_k_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
                  
            cbr_time_dif(cbr_temp_index)=(traf_dur(cell_k_new_index(n))- remained_time(cell_k_new_index(n)))*ts_number;   %calculate how many milliseconds had pasted
            cbr_percent(cbr_temp_index)=(cbr_percent(cbr_temp_index)*(cbr_time_dif(cbr_temp_index)-1)+real_sf(cell_k_new_index(n))/sf(cell_k_new_index(n)))/cbr_time_dif(cbr_temp_index);  %calculate average satified percentage
       else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
            real_sf(cell_k_new_index(n))=0; 
            traf_type(cell_k_new_index(n))=0;
            sf(cell_k_new_index(n))=0;
            traf_dur(cell_k_new_index(n))=0;
            data_rate(cell_k_new_index(n))=0;
            is_servered(cell_k_new_index(n))=0;
            remained_time(cell_k_new_index(n))=0;
                    
            cbr_time_dif(cbr_temp_index)=0;                 %indicate this traffic is failed
            cbr_percent(cbr_temp_index)=0;                  %calculate average satified percentage 
                      
            TOTAL_DROP=TOTAL_DROP+1;                         %calculate failed new calls
        end    
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
    cell_k_burst_index=find(in_cell==(k-1) & b_size~=0);                  %find all the nodes wich has burst traffic in cell 0
    amount=size(cell_k_burst_index,1);
    if amount>0
        total_size=sum(users(cell_k_burst_index,19));                     %calculate all burst traffic in this cell
        if c_available_sf>0                                               %if there are still some spreading codes left
            for n=1:(amount-1)                        %%%%%%%%%%%%go through all nodes except last one
            
                temp_index=find(n_id==cell_k_burst_index(n) & r_size>0);   %find all packets belong to current node (in array 'Packets')
                temp_amount=size(temp_index,1);                              %get the numbers of packet of this node 
            
                b_sf(cell_k_burst_index(n))=round(c_available_sf*b_size(cell_k_burst_index(n))/total_size);         %allocating spreading codes to node
                total_size=total_size-b_size(cell_k_burst_index(n));                                                %calculating total size again
                c_available_sf=c_available_sf- b_sf(cell_k_burst_index(n));                                         %reducing used spreading codes
                transmit_bit=b_sf(cell_k_burst_index(n))*min_data_rate/ts_number;                                   %%this amount of information has been transmitted
                b_size(cell_k_burst_index(n))=b_size(cell_k_burst_index(n))-transmit_bit;     
            
                for kk=1:temp_amount                                        %go through all burst packets belong to this node
                    mbit=r_size(temp_index(kk))-transmit_bit;                
                    if mbit<0                                              %if it still has capacity to transmit after current packet has been transmited                       
                        e_time(temp_index(kk))=TIME;                        %get end time
                        delay(temp_index(kk))=e_time(temp_index(kk))-s_time(temp_index(kk));       %calculate delay
                        transmit_bit=transmit_bit-r_size(temp_index(kk));    %calculate the ability to transmit next packet
                        r_size(temp_index(kk))=0;                            %now the current 'packet' has 0 bit
                        
                        p_id_fin(end+1,1)=id(temp_index(kk));
                        n_id_fin(end+1,1)=n_id(temp_index(kk));
                        delay_fin(end+1,1)=delay(temp_index(kk));
                        s_time_fin(end+1,1)=s_time(temp_index(kk));
                    else                                                    %if it can't fullfil current packet
                        r_size(temp_index(kk))=mbit;                         %calculate the left bits
                        break                                               %can't transmit next packet, end loop
                    end                           
                end                                 
        
                if b_size(cell_k_burst_index(n))<0                        %in case of negative size
                    b_size(cell_k_burst_index(n))=0;
                end 
                
                 pf=find(delay(temp_index)~=0);                  %clear memory in Packets
                id(temp_index(pf))=[];                                       
                s_time(temp_index(pf))=[];
                e_time(temp_index(pf))=[];
                r_size(temp_index(pf))=[];
                n_id(temp_index(pf))=[];
                delay(temp_index(pf))=[];
                
            end
    
            b_sf(cell_k_burst_index(end))=c_available_sf;           %%%%%%%%%%now is the last node turn
            c_available_sf=c_available_sf- b_sf(cell_k_burst_index(end));     
            temp_index=find(n_id==cell_k_burst_index(end) & r_size>0);   %find all packets belong to current node (in array 'Packets')
            temp_amount=size(temp_index,1);     
            transmit_bit=b_sf(cell_k_burst_index(end))*min_data_rate/ts_number;     
            b_size(cell_k_burst_index(end))=  b_size(cell_k_burst_index(end))-transmit_bit;
        
                for kk=1:temp_amount                                        %go through all burst packets belong to this node
                    mbit=r_size(temp_index(kk))-transmit_bit;                
                    if mbit<0                                              %if it still has capacity to transmit after current packet has been transmited
                                            %now the current 'packet' has 0 bit
                       
                        e_time(temp_index(kk))=TIME;                        %get end time
                        delay(temp_index(kk))=e_time(temp_index(kk))-s_time(temp_index(kk));       %calculate delay
                        transmit_bit=transmit_bit-r_size(temp_index(kk));    %calculate the ability to transmit next packet
                        r_size(temp_index(kk))=0;  
                        p_id_fin(end+1,1)=id(temp_index(kk));
                        n_id_fin(end+1,1)=n_id(temp_index(kk));
                        delay_fin(end+1,1)=delay(temp_index(kk));
                        s_time_fin(end+1,1)=s_time(temp_index(kk));
                    else                                                    %if it can't fullfil current packet
                        r_size(temp_index(kk))=mbit;                         %calculate the left bits                       
                        break                                               %can't transmit next packet, end loop
                    end                           
                end  
                
                pf=find(delay(temp_index)~=0);                  %clear memory in Packets
                id(temp_index(pf))=[];                                       
                s_time(temp_index(pf))=[];
                e_time(temp_index(pf))=[];
                r_size(temp_index(pf))=[];
                n_id(temp_index(pf))=[];
                delay(temp_index(pf))=[];
                
            if  b_size(cell_k_burst_index(end))<0
                b_size(cell_k_burst_index(end))=0;
            end 
            
        end
    end
    
    U(t,k)=(U(t,k)*((TIME-(t-1))*100-1)+(1-c_available_sf/available_sf))/((TIME-(t-1))*100);
end

if size(id,1)==0 || size(id,2)==0
    id=0;
    s_time=0;
    e_time=0;
    r_size=0;
    n_id=0;
    delay=0;
end

%Save data
traffic(:,1)=traf_type;
traffic(:,2)=traf_dur;
traffic(:,3)=data_rate;
traffic(:,4)=sf;
traffic(:,5)=remained_time;
traffic(:,6)=is_servered;
traffic(:,7)=is_handover;
traffic(:,8)=real_sf;
burst(:,1)=b_sf;
burst(:,2)=b_size;

%save data
BS_utilization=U;
Packets=[id s_time e_time r_size n_id delay];
nodes = [x_pos y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; 
CBRs=[cbr_id cbr_time_dif cbr_n_id cbr_percent];
packets_finnished=[p_id_fin n_id_fin delay_fin s_time_fin];
