close all
clear all
N   = 80;          % number of nodes
x   = 300;          % simulation area width
y   = 300;          %simulation area length
R   = 30;           %radio distance
cr = R/10;          %node plot size
ncolor  = zeros(1, N);
nparent = ncolor; 
[nx ny] = generateNodePosition(N, x, y);
ntable=getNeighborTable(N, nx, ny, R);
axis([0 x 0 y]);
hold on;

for k=1:N
    nx=x*rand(1);
    ny=y*rand(1);
    t = 0:0.05:2*pi;
    if k==1
      fill((x+cr*sin(t))/2, (y+cr*cos(t))/2, 'b');  
    end
    plot(nx+cr*sin(t), ny+cr*cos(t), 'b');
end

