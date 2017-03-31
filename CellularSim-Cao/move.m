%This function generates the new positions and new directions of each node.
function nodes=move(users, Cell_Num, N, R, BS_location);
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
burst=users(:,18:19);
for n=1:N*Cell_Num              % go through all the users
    rd= rand(1);                % generate a random value between 0, 1
    if rd<0.02                  % move to the left-reverse corner 
        plus=-2;
    end
    if rd >=0.02 & rd <0.05     % move to the left-forwarding corner 
        plus=-1;
    end
    if rd >=0.05 & rd <0.95     % move ahead 
        plus=0;
    end
    if rd >=0.95 & rd <0.98     % move right forwarding corner
        plus=1;
    end
    if rd >=0.98                % move right-reverse corner
        plus=2;
    end
    direction=dir(n)+plus;      % calculate new position

    new_x_pos(n)=x_pos(n)+v(n)*cos((direction)*pi/3+pi/6);  
    new_y_pos(n)=y_pos(n)+v(n)*sin((direction)*pi/3+pi/6);
     dx_pos(n)=new_x_pos(n)+offsite(n,1);
     dy_pos(n)=new_y_pos(n)+offsite(n,2);
end
nodes = [new_x_pos new_y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; % Nodes new position and new direction
