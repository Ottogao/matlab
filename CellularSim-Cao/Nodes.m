% This function intializes the positions and other parametres of each
% node. Each cell contains N nodes and there are Cell_Num cells
% The result contains RELATIVE coordinates of nodes in the cells and
% the 3rd colomn indicates which cell the node is.

%load parameters
r=rand(1,N*Cell_Num)*R;             % Generates node's initial random position by radius
theta=rand(1,N*Cell_Num)*2*pi;      % Generates node's initial random position by angle
x_pos=r.*sin(theta);                % Initial x-coordinate of the node
y_pos=r.*cos(theta);                % Initial y-coordinate of the node
offsite=zeros(2,N*Cell_Num);
for n=1:Cell_Num
    offsite(:,((n-1)*N+1):(n*N))=kron(ones(1,N),BS_location(:,n));
end

dx_pos=x_pos+offsite(1,:);
dy_pos=y_pos+offsite(2,:);
v = rand(1,Cell_Num*N)*(v_max-v_min)+v_min; % Random speed of the node

dir = ceil(rand(1,Cell_Num*N)*6);           % Initial random direction of the node
in_cell = floor((0:(N*Cell_Num-1))/N) ;    % in which cell the nodes are

traffic=zeros(8,N*Cell_Num);
traf_type=zeros(1,N*Cell_Num);
traf_dur=zeros(1,N*Cell_Num);
data_rate=zeros(1,N*Cell_Num);
sf=zeros(1,N*Cell_Num);
remained_time=zeros(1,N*Cell_Num);
is_servered=zeros(1,N*Cell_Num);
is_handover=zeros(1,N*Cell_Num);
real_sf=zeros(1,N*Cell_Num);

burst=zeros(2,N*Cell_Num);
b_sf=zeros(1,N*Cell_Num);
b_size=zeros(1,N*Cell_Num);

users = [x_pos' y_pos' offsite' in_cell' v' dir' dx_pos' dy_pos' traffic' burst'];  % make the nodes' 


%save users users;                   % save to data file