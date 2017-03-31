clf
N=1000;  % number of nodes
X = 800;
Y = 800;
cr = 5;
coordx = rand(1,N)*X;
coordy = rand(1,N)*Y;
coordx(1)=X/2; coordy(1)=Y/2;
figure(1);
axis image
hold on
axis([0 X 0 Y]);
t=0:0.05:2*pi;
for k=1:N
    if(k==1) fill(coordx(k)+cr*sin(t), coordy(k)+cr*cos(t), 'b');
    else plot(coordx(k)+cr*sin(t), coordy(k)+cr*cos(t), 'b');
    end
    %drawCircle(coordx(k), coordy(k));
end