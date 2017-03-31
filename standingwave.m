function[]=standingwave()
clf;
f = 100;  % wave frequency
dmax = 1;   % rightmost offset
d = 0:0.001:dmax;  % distance resolution
c = 10;  % wave propagation speed
figure(1)
for t=0:0.001:10    % simulation for 100 seconds
    E1 = cos(2*pi*f*(t-d/c));
    E2 = -cos(2*pi*f*(t-(2*dmax-d)/c));
    standingwave = E1+E2;
    %plot(d, E1, 'g', d, E2, 'b', d, standingwave, 'm'); 
    plot(d, standingwave);
    ylim([-3 3]);
    xlabel('Distance(m)');
    drawnow;
    pause(0.01);
end