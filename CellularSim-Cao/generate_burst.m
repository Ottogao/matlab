%This function generates burst traffic for each node

function nodes=generate_burst(users, Cell_Num, N, average_burst_rate,burst_packet_size);

% load parameters
x_pos=users(:,1);              % get users coordinates
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
offsite=users(:,3:4);
traffic=users(:,10:17);
new_x_pos=zeros(Cell_Num*N,1);  % initialize new position arrays
new_y_pos=zeros(Cell_Num*N,1);
in_cell = users(:,5);          
v = users(:,6);                   % velocity
dir = users(:,7);               % direction
burst=zeros(N*Cell_Num,2);
b_sf=users(:,18);
b_size=users(:,19);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global new_b_packet
new_b_packet=zeros(1,N*Cell_Num);
new_b_packet=poissinv(rand(1,N*Cell_Num),average_burst_rate);  %create new burst packet 

b_size=b_size+new_b_packet'*burst_packet_size;    %add to original one

burst(:,1)=b_sf;
burst(:,2)=b_size;

nodes = [x_pos y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; %save data

