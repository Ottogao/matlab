% This function checks whether a node is inside or outside the cell. If
% outside, the node position is flipped to the reverse direction inside the cell. 
% parameters: 
%   x,y: current relative location of this node, it might be outside of the cell
%   R: cell radius
function nodes=is_inside(users, Cell_Num, N, R)
x=users(:,1);              % get users coordinates
y=users(:,2);
dx=users(:,8);
dy=users(:,9);
in_cell=users(:,5);
offsite=users(:,3:4);
v = users(:,6);                  
dir = users(:,7);    
traffic=users(:,10:17);
burst=users(:,18:19);

for n=1:N*Cell_Num    
    if in_cell(n)==1   %cell number 1
        if y(n)>0.866*R && y(n)>=-1.7321*x(n) && y(n)>=1.7321*x(n)
             in_cell(n)=5;
             y(n)=y(n)-1.7321*R;
             x(n)=x(n); 
             offsite(n,1)=1.5*R;
             offsite(n,2)=-0.8660*R;
           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end
        
        if y(n)<=-1.7321*x(n) && y(n)>=1.7321*(x(n)+R) && y(n)>=0
    
             in_cell(n)=4;
             y(n)=y(n)-0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=0;
             offsite(n,2)=-1.7321*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end
        
         if y(n)<=1.7321*x(n) && y(n)>=1.7321*(R-x(n))
      
             in_cell(n)=3;
             y(n)=y(n)-0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=-1.5*R;
             offsite(n,2)=-0.866*R;
             
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end       
    end % the end of if in_cell==1
    
     if in_cell(n)==2  %cell number 2
        if y(n)>0.866*R && y(n)>=-1.7321*x(n) && y(n)>=1.7321*x(n)
             in_cell(n)=4;
             y(n)=y(n)-1.7321*R;
             x(n)=x(n); 
             offsite(n,1)=0;
             offsite(n,2)=-1.7321*R;
           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end
        
        
         if y(n)<=0 && y(n)<=-1.7321*(x(n)+R) && y(n)>=1.7321*x(n) 
             in_cell(n)=5;
             y(n)=y(n)+0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=1.5*R;
             offsite(n,2)=-0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end
         
        if y(n)<=-1.7321*x(n) && y(n)>=1.7321*(x(n)+R) && y(n)>=0 
             in_cell(n)=6;
             y(n)=y(n)-0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=1.5*R;
             offsite(n,2)=0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end        
     end  % the end of in_cell==2
         
     if in_cell(n)==3  %cell number 3        
        if y(n)<=-1.7321*x(n) && y(n)>=1.7321*(x(n)+R) && y(n)>=0    
             in_cell(n)=5;
             y(n)=y(n)-0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=1.5*R;
             offsite(n,2)=-0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end  
        
         if y(n)<=0 && y(n)<=-1.7321*(x(n)+R) && y(n)>=1.7321*x(n)   
             in_cell(n)=1;
             y(n)=y(n)+0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=0;
             offsite(n,2)=1.7321*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end
        
         if y(n)<=-0.866*R && y(n)<=1.7321*x(n) && y(n)<=-1.7321*x(n)
             in_cell(n)=6;
             y(n)=y(n)+1.732*R;
             x(n)=x(n); 
             offsite(n,1)=1.5*R;
             offsite(n,2)=0.8660*R;           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end       
     end  % the end of in_cell==3
     
     if in_cell(n)==4   %cell number 4
        if y(n)<=-0.866*R && y(n)<=1.7321*x(n) && y(n)<=-1.7321*x(n)
             in_cell(n)=2;
             y(n)=1.7321*R+y(n);
             x(n)=x(n); 
             offsite(n,1)=-1.5*R;
             offsite(n,2)=0.8660*R;           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end
        
        if y(n)<=0 && y(n)<=-1.7321*(x(n)+R) && y(n)>=1.7321*x(n)       
             in_cell(n)=6;
             y(n)=y(n)+0.866*R;
             x(n)=1.5*R+x(n);
             offsite(n,1)=1.5*R;
             offsite(n,2)=0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end
        
         if y(n)<=0 && y(n)<=1.7321*(x(n)-R) && y(n)>=-1.7321*x(n)     
             in_cell(n)=1;
             y(n)=y(n)+0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=0;
             offsite(n,2)=1.7321*R;             
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end       
    end % the end of if in_cell==4
    
    if in_cell(n)==5  %cell number 5        
        if y(n)>=0 && y(n)>=1.7321*(R-x(n)) && y(n)<=1.7321*x(n)   
             in_cell(n)=2;
             y(n)=y(n)-0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=-1.5*R;
             offsite(n,2)=0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end  
        
         if y(n)<=0 && y(n)<=1.7321*(x(n)-R) && y(n)>=-1.7321*x(n) 
             in_cell(n)=3;
             y(n)=y(n)+0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=-1.5*R;
             offsite(n,2)=-0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end
        
         if y(n)<=-0.866*R && y(n)<=1.7321*x(n) && y(n)<=-1.7321*x(n)
             in_cell(n)=1;
             y(n)=y(n)+1.7321*R;
             x(n)=x(n); 
             offsite(n,1)=0;
             offsite(n,2)=1.7321*R;           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end       
     end  % the end of in_cell==5
     
     if in_cell(n)==6  %cell number 6       
        if y(n)>=0 && y(n)>=1.7321*(R-x(n)) && y(n)<=1.7321*x(n)   
             in_cell(n)=4;
             y(n)=y(n)-0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=0;
             offsite(n,2)=-1.7321*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
        end  
        
         if y(n)<=0 && y(n)<=1.7321*(x(n)-R) && y(n)>=-1.7321*x(n) 
             in_cell(n)=2;
             y(n)=y(n)+0.866*R;
             x(n)=x(n)-1.5*R;
             offsite(n,1)=-1.5*R;
             offsite(n,2)=0.866*R;
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end
        
         if y(n)>0.866*R && y(n)>=-1.7321*x(n) && y(n)>=1.7321*x(n)
             in_cell(n)=3;
             y(n)=y(n)-1.7321*R;
             x(n)=x(n); 
             offsite(n,1)=-1.5*R;
             offsite(n,2)=-0.866*R;           
             dx(n)=x(n)+offsite(n,1);
             dy(n)=y(n)+offsite(n,2);
         end       
     end  % the end of in_cell==6
end

nodes = [x y offsite in_cell v dir dx dy traffic burst];