%This function change the relative coordinates when one node move from one
%cell to another cell.

function nodes=change_relative(users, Cell_Num, N, R, a_in_cell, b_in_cell, BS_location )

x=users(:,1);              % get user's relative coordinates
y=users(:,2);
dx=users(:,8);             % get user's absolut coordinates
dy=users(:,9);
in_cell=users(:,5);
offsite=users(:,3:4);
v = users(:,6);                 
dir = users(:,7);
traffic=users(:,10:17);
burst=users(:,18:19);

for n=1:N*Cell_Num
    if b_in_cell(n)==0
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,1);
             offsite(n,2)=BS_location(2,1);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
    end
    
     if b_in_cell(n)==1
         if a_in_cell(n)~=b_in_cell(n)
            offsite(n,1)=BS_location(1,2);
             offsite(n,2)=BS_location(2,2);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
    end
   
    if b_in_cell(n)==2
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,3);
             offsite(n,2)=BS_location(2,3);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
    end
    
     if b_in_cell(n)==3
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,4);
             offsite(n,2)=BS_location(2,4);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
     end
    
      if b_in_cell(n)==4
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,5);
             offsite(n,2)=BS_location(2,5);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
      end
    
       if b_in_cell(n)==5
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,6);
             offsite(n,2)=BS_location(2,6);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
       end
    
       if b_in_cell(n)==6
         if a_in_cell(n)~=b_in_cell(n)
             offsite(n,1)=BS_location(1,7);
             offsite(n,2)=BS_location(2,7);
             x(n)=dx(n)-offsite(n,1);
             y(n)=dy(n)-offsite(n,2);
         end
       end
end
nodes = [x y offsite in_cell v dir dx dy traffic burst];