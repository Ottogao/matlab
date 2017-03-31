%This function is to allocation spreading code to nodes and send packet

function nodes=allocate_send(users,Cell_Num,N,available_sf,ts_number,burst_packet_size,min_data_rate);

% load parameters
x_pos=users(:,1);              
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
offsite=users(:,3:4);
traffic=zeros(N*Cell_Num,12);
traf_type=users(:,10);
traf_dur=users(:,11);
data_rate=users(:,12);
sf=users(:,13);
tr_time=users(:,14);
re_time=users(:,15);
remained_time=users(:,16);
consecutive_drop=users(:,17);
total_drop=users(:,18);
is_servered=users(:,19);
is_handover=users(:,20);
real_sf=users(:,21);
in_cell = users(:,5);          
v = users(:,6);                 
dir = users(:,7);
burst=zeros(N*Cell_Num,2);
b_sf=users(:,22);
b_size=users(:,23);              
c_available_sf=available_sf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_0_totalserve_index=find(in_cell==0 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 0 which are fully served and not a handover
for n=1:size(cell_0_totalserve_index,1)
    remained_time(cell_0_totalserve_index(n))= remained_time(cell_0_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_0_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_0_halfserve_index=find(in_cell==0 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 0 which do not reach the quality of service
for n=1:size(cell_0_halfserve_index,1)
    if c_available_sf>=sf(cell_0_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_0_halfserve_index(n))=sf(cell_0_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_0_halfserve_index(n))= remained_time(cell_0_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_0_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_0_handover_index=find(in_cell==0 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 0 which is generating taffic and has made a handover
for n=1:size(cell_0_handover_index,1)                                 %go through all this kind of nodes
    
    if  c_available_sf>=sf(cell_0_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_0_handover_index(n))=sf(cell_0_handover_index(n));
        is_servered(cell_0_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_0_handover_index(n));      %spreading codes have been used  
        remained_time(cell_0_handover_index(n))=remained_time(cell_0_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_0_handover_index(n))          %a failed handover call
            real_sf(cell_0_handover_index(n))=0;
            traf_type(cell_0_handover_index(n))=0; 
            sf(cell_0_handover_index(n))=0;
            traf_dur(cell_0_handover_index(n))=0;
            data_rate(cell_0_handover_index(n))=0;
            is_servered(cell_0_handover_index(n))=0;
            remained_time(cell_0_handover_index(n))=0;
            is_handover(cell_0_handover_index(n))==0;
             
            global HANDOVER_DROP TOTAL_DROP                               %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1; 
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_0_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_0_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_0_handover_index(n));      %spreading codes have been used 
            remained_time(cell_0_handover_index(n))=remained_time(cell_0_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_0_new_index=find(in_cell==0 & traf_type~=0 & is_servered==0);   %find all nodes in cell 0 which is generating new traffic
for n=1:size(cell_0_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_0_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_0_new_index(n))=sf(cell_0_new_index(n));       
        is_servered(cell_0_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_0_new_index(n));      %spreading codes have been used   
        remained_time(cell_0_new_index(n))=remained_time(cell_0_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_0_new_index(n))=0; 
        traf_type(cell_0_new_index(n))=0;
         sf(cell_0_new_index(n))=0;
         traf_dur(cell_0_new_index(n))=0;
         data_rate(cell_0_new_index(n))=0;
         is_servered(cell_0_new_index(n))=0;
         remained_time(cell_0_new_index(n))=0;
         
         global TOTAL_DROP;              %calculate failed new calls
         TOTAL_DROP=TOTAL_DROP+1; 
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_0_burst_index=find(in_cell==0 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 0
if size(cell_0_burst_index,1)>0
    total_size=sum(users(cell_0_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_0_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_0_burst_index(n))=round(c_available_sf*b_size(cell_0_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_0_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_0_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_0_burst_index(n))=b_size(cell_0_burst_index(n))-b_sf(cell_0_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_0_burst_index(n))<0                        %in case of negative size
                b_size(cell_0_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_0_burst_index(size(cell_0_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_0_burst_index(size(cell_0_burst_index,1)))= b_size(cell_0_burst_index(size(cell_0_burst_index,1)))-b_sf(cell_0_burst_index(size(cell_0_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_0_burst_index(size(cell_0_burst_index,1)))<0
            b_size(cell_0_burst_index(size(cell_0_burst_index,1)))=0;
        end
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_1_totalserve_index=find(in_cell==1 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 1 which are fully served and not a handover
for n=1:size(cell_1_totalserve_index,1)
    remained_time(cell_1_totalserve_index(n))= remained_time(cell_1_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_1_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_1_halfserve_index=find(in_cell==1 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 1 which do not reach the quality of service
for n=1:size(cell_1_halfserve_index,1)
    if c_available_sf>=sf(cell_1_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_1_halfserve_index(n))=sf(cell_1_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_1_halfserve_index(n))= remained_time(cell_1_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_1_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_1_handover_index=find(in_cell==1 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 1 which is generating taffic and has made a handover
for n=1:size(cell_1_handover_index,1)                                 %go through all this kind of nodes
    
    if  c_available_sf>=sf(cell_1_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_1_handover_index(n))=sf(cell_1_handover_index(n));
        is_servered(cell_1_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_1_handover_index(n));      %spreading codes have been used  
        remained_time(cell_1_handover_index(n))=remained_time(cell_1_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_1_handover_index(n))          %a failed handover call
            real_sf(cell_1_handover_index(n))=0;
            traf_type(cell_1_handover_index(n))=0; 
            sf(cell_1_handover_index(n))=0;
            traf_dur(cell_1_handover_index(n))=0;
            data_rate(cell_1_handover_index(n))=0;
            is_servered(cell_1_handover_index(n))=0;
            remained_time(cell_1_handover_index(n))=0;
             is_handover(cell_1_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1;  
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_1_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_1_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_1_handover_index(n));      %spreading codes have been used 
            remained_time(cell_1_handover_index(n))=remained_time(cell_1_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_1_new_index=find(in_cell==1 & traf_type~=0 & is_servered==0);   %find all nodes in cell 1 which is generating new traffic
for n=1:size(cell_1_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_1_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_1_new_index(n))=sf(cell_1_new_index(n));       
        is_servered(cell_1_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_1_new_index(n));      %spreading codes have been used   
        remained_time(cell_1_new_index(n))=remained_time(cell_1_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_1_new_index(n))=0; 
        traf_type(cell_1_new_index(n))=0;
         sf(cell_1_new_index(n))=0;
         traf_dur(cell_1_new_index(n))=0;
         data_rate(cell_1_new_index(n))=0;
         is_servered(cell_1_new_index(n))=0;
         remained_time(cell_1_new_index(n))=0;
         
         global TOTAL_DROP              %calculate failed new calls
         TOTAL_DROP=TOTAL_DROP+1; 
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_1_burst_index=find(in_cell==1 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 1
if size(cell_1_burst_index,1)>0
    total_size=sum(users(cell_1_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_1_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_1_burst_index(n))=round(c_available_sf*b_size(cell_1_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_1_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_1_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_1_burst_index(n))=b_size(cell_1_burst_index(n))-b_sf(cell_1_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_1_burst_index(n))<0                        %in case of negative size
                b_size(cell_1_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_1_burst_index(size(cell_1_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_1_burst_index(size(cell_1_burst_index,1)))= b_size(cell_1_burst_index(size(cell_1_burst_index,1)))-b_sf(cell_1_burst_index(size(cell_1_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_1_burst_index(size(cell_1_burst_index,1)))<0
            b_size(cell_1_burst_index(size(cell_1_burst_index,1)))=0;
        end
    
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_2_totalserve_index=find(in_cell==2 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 2 which are fully served and not a handover
for n=1:size(cell_2_totalserve_index,1)
    remained_time(cell_2_totalserve_index(n))= remained_time(cell_2_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_2_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_2_halfserve_index=find(in_cell==2 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 2 which do not reach the quality of service
for n=1:size(cell_2_halfserve_index,1)
    if c_available_sf>=sf(cell_2_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_2_halfserve_index(n))=sf(cell_2_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_2_halfserve_index(n))= remained_time(cell_2_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_2_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_2_handover_index=find(in_cell==2 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 2 which is generating taffic and has made a handover
for n=1:size(cell_2_handover_index,1)                                 %go through all this kind of nodes
   
    if  c_available_sf>=sf(cell_2_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_2_handover_index(n))=sf(cell_2_handover_index(n));
        is_servered(cell_2_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_2_handover_index(n));      %spreading codes have been used  
        remained_time(cell_2_handover_index(n))=remained_time(cell_2_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_2_handover_index(n))          %a failed handover call
            real_sf(cell_2_handover_index(n))=0;
            traf_type(cell_2_handover_index(n))=0; 
            sf(cell_2_handover_index(n))=0;
            traf_dur(cell_2_handover_index(n))=0;
            data_rate(cell_2_handover_index(n))=0;
            is_servered(cell_2_handover_index(n))=0;
            remained_time(cell_2_handover_index(n))=0;
             is_handover(cell_2_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1; 
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_2_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_2_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_2_handover_index(n));      %spreading codes have been used 
            remained_time(cell_2_handover_index(n))=remained_time(cell_2_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_2_new_index=find(in_cell==2 & traf_type~=0 & is_servered==0);   %find all nodes in cell 2 which is generating new traffic
for n=1:size(cell_2_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_2_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_2_new_index(n))=sf(cell_2_new_index(n));       
        is_servered(cell_2_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_2_new_index(n));      %spreading codes have been used   
        remained_time(cell_2_new_index(n))=remained_time(cell_2_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_2_new_index(n))=0; 
        traf_type(cell_2_new_index(n))=0;
         sf(cell_2_new_index(n))=0;
         traf_dur(cell_2_new_index(n))=0;
         data_rate(cell_2_new_index(n))=0;
         is_servered(cell_2_new_index(n))=0;
         remained_time(cell_2_new_index(n))=0;
         
         global TOTAL_DROP              %calculate failed new calls
         TOTAL_DROP=TOTAL_DROP+1; 
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_2_burst_index=find(in_cell==2 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 2
if size(cell_2_burst_index,1)>0
    total_size=sum(users(cell_2_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_2_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_2_burst_index(n))=round(c_available_sf*b_size(cell_2_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_2_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_2_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_2_burst_index(n))=b_size(cell_2_burst_index(n))-b_sf(cell_2_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_2_burst_index(n))<0                        %in case of negative size
                b_size(cell_2_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_2_burst_index(size(cell_2_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_2_burst_index(size(cell_2_burst_index,1)))= b_size(cell_2_burst_index(size(cell_2_burst_index,1)))-b_sf(cell_2_burst_index(size(cell_2_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_2_burst_index(size(cell_2_burst_index,1)))<0
            b_size(cell_2_burst_index(size(cell_2_burst_index,1)))=0;
        end
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_3_totalserve_index=find(in_cell==3 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 3 which are fully served and not a handover
for n=1:size(cell_3_totalserve_index,1)
    remained_time(cell_3_totalserve_index(n))= remained_time(cell_3_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_3_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_3_halfserve_index=find(in_cell==3 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 3 which do not reach the quality of service
for n=1:size(cell_3_halfserve_index,1)
    if c_available_sf>=sf(cell_3_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_3_halfserve_index(n))=sf(cell_3_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_3_halfserve_index(n))= remained_time(cell_3_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_3_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_3_handover_index=find(in_cell==3 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 3 which is generating taffic and has made a handover
for n=1:size(cell_3_handover_index,1)                                 %go through all this kind of nodes
   
    if  c_available_sf>=sf(cell_3_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_3_handover_index(n))=sf(cell_3_handover_index(n));
        is_servered(cell_3_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_3_handover_index(n));      %spreading codes have been used  
        remained_time(cell_3_handover_index(n))=remained_time(cell_3_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_3_handover_index(n))          %a failed handover call
            real_sf(cell_3_handover_index(n))=0;
            traf_type(cell_3_handover_index(n))=0; 
            sf(cell_3_handover_index(n))=0;
            traf_dur(cell_3_handover_index(n))=0;
            data_rate(cell_3_handover_index(n))=0;
            is_servered(cell_3_handover_index(n))=0;
            remained_time(cell_3_handover_index(n))=0;
             is_handover(cell_3_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1;    
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_3_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_3_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_3_handover_index(n));      %spreading codes have been used 
            remained_time(cell_3_handover_index(n))=remained_time(cell_3_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_3_new_index=find(in_cell==3 & traf_type~=0 & is_servered==0);   %find all nodes in cell 3 which is generating new traffic
for n=1:size(cell_3_new_index,1)                                    %go through all this kind of nodes
   
    if c_available_sf>=sf(cell_3_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_3_new_index(n))=sf(cell_3_new_index(n));       
        is_servered(cell_3_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_3_new_index(n));      %spreading codes have been used   
        remained_time(cell_3_new_index(n))=remained_time(cell_3_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_3_new_index(n))=0; 
        traf_type(cell_3_new_index(n))=0;
         sf(cell_3_new_index(n))=0;
         traf_dur(cell_3_new_index(n))=0;
         data_rate(cell_3_new_index(n))=0;
         is_servered(cell_3_new_index(n))=0;
         remained_time(cell_3_new_index(n))=0;
         
         global TOTAL_DROP ;              %calculate failed new calls
        TOTAL_DROP= TOTAL_DROP+1;
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_3_burst_index=find(in_cell==3 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 3
if size(cell_3_burst_index,1)>0
    total_size=sum(users(cell_3_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_3_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_3_burst_index(n))=round(c_available_sf*b_size(cell_3_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_3_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_3_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_3_burst_index(n))=b_size(cell_3_burst_index(n))-b_sf(cell_3_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_3_burst_index(n))<0                        %in case of negative size
                b_size(cell_3_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_3_burst_index(size(cell_3_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_3_burst_index(size(cell_3_burst_index,1)))= b_size(cell_3_burst_index(size(cell_3_burst_index,1)))-b_sf(cell_3_burst_index(size(cell_3_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_3_burst_index(size(cell_3_burst_index,1)))<0
            b_size(cell_3_burst_index(size(cell_3_burst_index,1)))=0;
        end
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_4_totalserve_index=find(in_cell==4 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 4 which are fully served and not a handover
for n=1:size(cell_4_totalserve_index,1)
    remained_time(cell_4_totalserve_index(n))= remained_time(cell_4_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_4_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_4_halfserve_index=find(in_cell==4 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 4 which do not reach the quality of service
for n=1:size(cell_4_halfserve_index,1)
    if c_available_sf>=sf(cell_4_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_4_halfserve_index(n))=sf(cell_4_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_4_halfserve_index(n))= remained_time(cell_4_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_4_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_4_handover_index=find(in_cell==4 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 4 which is generating taffic and has made a handover
for n=1:size(cell_4_handover_index,1)                                 %go through all this kind of nodes
   
    if  c_available_sf>=sf(cell_4_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_4_handover_index(n))=sf(cell_4_handover_index(n));
        is_servered(cell_4_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_4_handover_index(n));      %spreading codes have been used  
        remained_time(cell_4_handover_index(n))=remained_time(cell_4_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_4_handover_index(n))          %a failed handover call
            real_sf(cell_4_handover_index(n))=0;
            traf_type(cell_4_handover_index(n))=0; 
            sf(cell_4_handover_index(n))=0;
            traf_dur(cell_4_handover_index(n))=0;
            data_rate(cell_4_handover_index(n))=0;
            is_servered(cell_4_handover_index(n))=0;
            remained_time(cell_4_handover_index(n))=0;
             is_handover(cell_4_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1;    
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_4_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_4_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_4_handover_index(n));      %spreading codes have been used 
            remained_time(cell_4_handover_index(n))=remained_time(cell_4_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_4_new_index=find(in_cell==4 & traf_type~=0 & is_servered==0);   %find all nodes in cell 4 which is generating new traffic
for n=1:size(cell_4_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_4_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_4_new_index(n))=sf(cell_4_new_index(n));       
        is_servered(cell_4_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_4_new_index(n));      %spreading codes have been used   
        remained_time(cell_4_new_index(n))=remained_time(cell_4_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_4_new_index(n))=0; 
        traf_type(cell_4_new_index(n))=0;
         sf(cell_4_new_index(n))=0;
         traf_dur(cell_4_new_index(n))=0;
         data_rate(cell_4_new_index(n))=0;
         is_servered(cell_4_new_index(n))=0;
         remained_time(cell_4_new_index(n))=0;
         
         global TOTAL_DROP                                                   %calculate failed new calls
            TOTAL_DROP= TOTAL_DROP+1;
        
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_4_burst_index=find(in_cell==4 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 4
if size(cell_4_burst_index,1)>0
    total_size=sum(users(cell_4_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_4_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_4_burst_index(n))=round(c_available_sf*b_size(cell_4_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_4_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_4_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_4_burst_index(n))=b_size(cell_4_burst_index(n))-b_sf(cell_4_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_4_burst_index(n))<0                        %in case of negative size
                b_size(cell_4_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_4_burst_index(size(cell_4_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_4_burst_index(size(cell_4_burst_index,1)))= b_size(cell_4_burst_index(size(cell_4_burst_index,1)))-b_sf(cell_4_burst_index(size(cell_4_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_4_burst_index(size(cell_4_burst_index,1)))<0
            b_size(cell_4_burst_index(size(cell_4_burst_index,1)))=0;
        end
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_5_totalserve_index=find(in_cell==5 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 5 which are fully served and not a handover
for n=1:size(cell_5_totalserve_index,1)
    remained_time(cell_5_totalserve_index(n))= remained_time(cell_5_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_5_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_5_halfserve_index=find(in_cell==5 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 5 which do not reach the quality of service
for n=1:size(cell_5_halfserve_index,1)
    if c_available_sf>=sf(cell_5_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_5_halfserve_index(n))=sf(cell_5_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_5_halfserve_index(n))= remained_time(cell_5_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_5_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_5_handover_index=find(in_cell==5 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 5 which is generating taffic and has made a handover
for n=1:size(cell_5_handover_index,1)                                 %go through all this kind of nodes
   
    if  c_available_sf>=sf(cell_5_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_5_handover_index(n))=sf(cell_5_handover_index(n));
        is_servered(cell_5_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_5_handover_index(n));      %spreading codes have been used  
        remained_time(cell_5_handover_index(n))=remained_time(cell_5_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_5_handover_index(n))          %a failed handover call
            real_sf(cell_5_handover_index(n))=0;
            traf_type(cell_5_handover_index(n))=0; 
            sf(cell_5_handover_index(n))=0;
            traf_dur(cell_5_handover_index(n))=0;
            data_rate(cell_5_handover_index(n))=0;
            is_servered(cell_5_handover_index(n))=0;
            remained_time(cell_5_handover_index(n))=0;
             is_handover(cell_5_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1;   
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_5_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_5_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_5_handover_index(n));      %spreading codes have been used 
            remained_time(cell_5_handover_index(n))=remained_time(cell_5_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_5_new_index=find(in_cell==5 & traf_type~=0 & is_servered==0);   %find all nodes in cell 5 which is generating new traffic
for n=1:size(cell_5_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_5_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_5_new_index(n))=sf(cell_5_new_index(n));       
        is_servered(cell_5_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_5_new_index(n));      %spreading codes have been used   
        remained_time(cell_5_new_index(n))=remained_time(cell_5_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_5_new_index(n))=0; 
        traf_type(cell_5_new_index(n))=0;
         sf(cell_5_new_index(n))=0;
         traf_dur(cell_5_new_index(n))=0;
         data_rate(cell_5_new_index(n))=0;
         is_servered(cell_5_new_index(n))=0;
         remained_time(cell_5_new_index(n))=0;
         
         global TOTAL_DROP              %calculate failed new calls
        TOTAL_DROP= TOTAL_DROP+1;
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_5_burst_index=find(in_cell==5 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 5
if size(cell_5_burst_index,1)>0
    total_size=sum(users(cell_5_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_5_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_5_burst_index(n))=round(c_available_sf*b_size(cell_5_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_5_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_5_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_5_burst_index(n))=b_size(cell_5_burst_index(n))-b_sf(cell_5_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_5_burst_index(n))<0                        %in case of negative size
                b_size(cell_5_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_5_burst_index(size(cell_5_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_5_burst_index(size(cell_5_burst_index,1)))= b_size(cell_5_burst_index(size(cell_5_burst_index,1)))-b_sf(cell_5_burst_index(size(cell_5_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_5_burst_index(size(cell_5_burst_index,1)))<0
            b_size(cell_5_burst_index(size(cell_5_burst_index,1)))=0;
        end
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for callings
cell_6_totalserve_index=find(in_cell==6 & traf_type~=0 & is_servered==1 & is_handover==0 & sf==real_sf);  %find all nodes in cell 6 which are fully served and not a handover
for n=1:size(cell_6_totalserve_index,1)
    remained_time(cell_6_totalserve_index(n))= remained_time(cell_6_totalserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot     
end
c_available_sf=available_sf-sum(users(cell_6_totalserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

cell_6_halfserve_index=find(in_cell==6 & traf_type~=0 & is_servered==1 & is_handover==0 & sf~=real_sf); %find all nodes in cell 6 which do not reach the quality of service
for n=1:size(cell_6_halfserve_index,1)
    if c_available_sf>=sf(cell_6_halfserve_index(n))    %if there are enough spread codes for it
        real_sf(cell_6_halfserve_index(n))=sf(cell_6_halfserve_index(n));  %this node will reach the quality of service               
    end
    remained_time(cell_6_halfserve_index(n))= remained_time(cell_6_halfserve_index(n))-(1/ts_number);  %reduse remained_time by the time of one time slot      
end
c_available_sf=c_available_sf-sum(users(cell_6_halfserve_index,21));        %calculate the number of spreading codes have been used and reduce them.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for handover calls:
cell_6_handover_index=find(in_cell==6 &traf_type~=0 & is_servered==1 & is_handover==1); % find all nodes in cell 6 which is generating taffic and has made a handover
for n=1:size(cell_6_handover_index,1)                                 %go through all this kind of nodes
  
    if  c_available_sf>=sf(cell_6_handover_index(n))               %if there are enough spreading codes for it
        real_sf(cell_6_handover_index(n))=sf(cell_6_handover_index(n));
        is_servered(cell_6_handover_index(n))=1;                 %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_6_handover_index(n));      %spreading codes have been used  
        remained_time(cell_6_handover_index(n))=remained_time(cell_6_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                           % if spreading codes is not enough, this is a dropped handover call    
        if c_available_sf<0.5*sf(cell_6_handover_index(n))          %a failed handover call
            real_sf(cell_6_handover_index(n))=0;
            traf_type(cell_6_handover_index(n))=0; 
            sf(cell_6_handover_index(n))=0;
            traf_dur(cell_6_handover_index(n))=0;
            data_rate(cell_6_handover_index(n))=0;
            is_servered(cell_6_handover_index(n))=0;
            remained_time(cell_6_handover_index(n))=0;
             is_handover(cell_6_handover_index(n))=0;
             
            global HANDOVER_DROP TOTAL_DROP                              %calculate failed handover calls
            HANDOVER_DROP=HANDOVER_DROP+1;     
            TOTAL_DROP=TOTAL_DROP+1;
        else
            real_sf(cell_6_handover_index(n))=c_available_sf;        %can't reach the quality of service but still connected
            is_servered(cell_6_handover_index(n))=1;                 %this node can be servered
            c_available_sf=c_available_sf-real_sf(cell_6_handover_index(n));      %spreading codes have been used 
            remained_time(cell_6_handover_index(n))=remained_time(cell_6_handover_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
        end                                              
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for new calls
cell_6_new_index=find(in_cell==6 & traf_type~=0 & is_servered==0);   %find all nodes in cell 6 which is generating new traffic
for n=1:size(cell_6_new_index,1)                                    %go through all this kind of nodes
    
    if c_available_sf>=sf(cell_6_new_index(n))                       %if there are enough spreading codes for it
        real_sf(cell_6_new_index(n))=sf(cell_6_new_index(n));       
        is_servered(cell_6_new_index(n))=1;                         %this node can be servered
        c_available_sf=c_available_sf-real_sf(cell_6_new_index(n));      %spreading codes have been used   
        remained_time(cell_6_new_index(n))=remained_time(cell_6_new_index(n))-(1/ts_number);  %reduse remained_time by the time for one time slot
    else                                                            %if there is no spreading coda can be used, this is a dropped new call                  
        real_sf(cell_6_new_index(n))=0; 
        traf_type(cell_6_new_index(n))=0;
         sf(cell_6_new_index(n))=0;
         traf_dur(cell_6_new_index(n))=0;
         data_rate(cell_6_new_index(n))=0;
         is_servered(cell_6_new_index(n))=0;
         remained_time(cell_6_new_index(n))=0;
         
         global TOTAL_DROP              %calculate failed new calls
         TOTAL_DROP=TOTAL_DROP+1; 
    end    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for burst traffic
cell_6_burst_index=find(in_cell==6 & b_size~=0);                  %find all the nodes wich has burst traffic in cell 6
if size(cell_6_burst_index,1)>0
    total_size=sum(users(cell_6_burst_index,23));                     %calculate all burst traffic in this cell
    if c_available_sf>0                                               %if there are still some spreading codes left
        for n=1:(size(cell_6_burst_index,1)-1)                        %go through all nodes except last one
            b_sf(cell_6_burst_index(n))=round(c_available_sf*b_size(cell_6_burst_index(n))/total_size);         %allocating spreading codes to node
            total_size=total_size-b_size(cell_6_burst_index(n));                                                %calculating total size again
            c_available_sf=c_available_sf- b_sf(cell_6_burst_index(n));                                         %reducing used spreading codes
            b_size(cell_6_burst_index(n))=b_size(cell_6_burst_index(n))-b_sf(cell_6_burst_index(n))*min_data_rate/ts_number;      %this amount of information has been sent
        
            if b_size(cell_6_burst_index(n))<0                        %in case of negative size
                b_size(cell_6_burst_index(n))=0;
            end
        
        end
    
        b_sf(cell_6_burst_index(size(cell_6_burst_index,1)))=c_available_sf;            %now is the last node turn
        b_size(cell_6_burst_index(size(cell_6_burst_index,1)))= b_size(cell_6_burst_index(size(cell_6_burst_index,1)))-b_sf(cell_6_burst_index(size(cell_6_burst_index,1)))*min_data_rate/ts_number;
    
        if  b_size(cell_6_burst_index(size(cell_6_burst_index,1)))<0
            b_size(cell_6_burst_index(size(cell_6_burst_index,1)))=0;
        end
    
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Save data
traffic(:,1)=traf_type;
traffic(:,2)=traf_dur;
traffic(:,3)=data_rate;
traffic(:,4)=sf;
traffic(:,5)=tr_time;
traffic(:,6)=re_time;
traffic(:,7)=remained_time;
traffic(:,8)=consecutive_drop;
traffic(:,9)=total_drop;
traffic(:,10)=is_servered;
traffic(:,11)=is_handover;
traffic(:,12)=real_sf;
burst(:,1)=b_sf;
burst(:,2)=b_size;

nodes = [x_pos y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; %save data
