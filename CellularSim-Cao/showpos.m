function showpos(users, step, N, R, BS_location, Cell_Num)
theta=linspace(0,2*pi,40);
x_pos=users(:,1);
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
dir=users(:,7);
figure(1)
clf
axis square
axis([-2.5*R 2.5*R -3*sqrt(3)*R/2 3*sqrt(3)*R/2]);
box on
hold on
text(3*R-200,3*R-50, sprintf('step=%d', step));
coordx=[-R/2 -R -R/2 R/2 R R/2 -R/2];
coordy=[-R*sqrt(3)/2 0 R*sqrt(3)/2 R*sqrt(3)/2 0, -sqrt(3)*R/2 -sqrt(3)*R/2];
for c=1:Cell_Num        % go through all the cells
    plot(coordx+BS_location(1,c), coordy+BS_location(2,c)); % plot the cell boundaries
    for n=1:N
     %  a = x_pos((c-1)*N+n)+0.15*R*cos(theta)+BS_location(1,c);
        % b = y_pos((c-1)*N+n)+0.15*R*sin(theta)+BS_location(2,c);
         a = dx_pos((c-1)*N+n)+0.06*R*cos(theta);
         b = dy_pos((c-1)*N+n)+0.06*R*sin(theta);
        plot(a,b,'b');
        %if c==1
            %text(x_pos((c-1)*N+n)+BS_location(1,c)-50, y_pos((c-1)*N+n)+BS_location(2,c), ...
             %   sprintf('%d,d=%d', (c-1)*N+n, dir((c-1)*N+n)));
        %end
    end
end
pause(0.1);