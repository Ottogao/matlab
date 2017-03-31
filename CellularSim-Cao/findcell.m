function nodes=findcell(users, N, Cell_Num, R);% find the current cell for one nodes

% load parameters
x_pos=users(:,1);              % get users coordinates
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
in_cell=users(:,5);
offsite=users(:,3:4);
v = users(:,6);                   
dir = users(:,7);               
traffic=users(:,10:17);
burst=users(:,18:19);
for n=1:N*Cell_Num
    if (abs(dx_pos(n))<R/2&abs(dy_pos(n))<0.866*R)|(abs(dx_pos(n))>=R/2&abs(dx_pos(n))<R&abs(dy_pos(n))<1.732*(R-abs(dx_pos(n))))
        in_cell(n)=0;
    end
    
    if (abs(dx_pos(n))<R/2&abs(dy_pos(n))>=0.866*R&abs(dy_pos(n))<2.598*R)|(abs(dx_pos(n))>=R/2&abs(dx_pos(n))<=R&abs(dy_pos(n))<=(2*R-abs(dx_pos(n)))*1.732&abs(dy_pos(n))>=abs(dx_pos(n))*1.732)
        if dy_pos(n)>0
        in_cell(n)=1;
        else  
            in_cell(n)=4;
        end
    end
    
    if abs(dx_pos(n))>=R/2&abs(dx_pos(n))<R&abs(dy_pos(n))>=1.732*(R-abs(dx_pos(n)))&abs(dy_pos(n))<1.732*abs(dx_pos(n))
        if dx_pos(n)>0
            if dy_pos(n)>0
                in_cell(n)=6;
            else
                in_cell(n)=5;
            end
        else 
            if dy_pos(n)>0
                in_cell(n)=2;
            else
                in_cell(n)=3;
            end
        end
 
    end
    
    
    if abs(dx_pos(n))>=R&abs(dx_pos(n))<2*R&abs(dy_pos(n))<=1.732*R
        if dx_pos(n)>0
            if dy_pos(n)>0
                in_cell(n)=6;
            else
                in_cell(n)=5;
            end
        else
            if dy_pos(n)>0
                in_cell(n)=2;
            else
                in_cell(n)=3;
            end
        end
    end
    
    if abs(dx_pos(n))<=4.33*R&abs(dx_pos(n))>=2*R&abs(dy_pos(n))>=1.732*(abs(dx_pos(n))-2*R)&abs(dy_pos(n))<=1.732*(3*R-abs(dx_pos(n)))
        if dx_pos(n)>0
            if dy_pos(n)>0
                in_cell(n)=6;
            else
                in_cell(n)=5;
            end
        else
            if dy_pos(n)>0
                in_cell(n)=2;
            else
                in_cell(n)=3;
            end
        end
    end

end % the end of for loop n
nodes = [x_pos y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; %save data