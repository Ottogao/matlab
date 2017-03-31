coord = [1 0.5];
r = 0.2;
t=0:0.01:2*pi;
xr = coord(1)+r*sin(t);
yr = coord(2)+r*cos(t);
figure(1)
plot(xr,yr);
axis image
axis([0 2 0 2]);



