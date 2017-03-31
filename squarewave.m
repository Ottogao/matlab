% Square wave synthesization using Fourier series
% modified by Chao Gao, 07.02.2011

% Fourier series is used to synthesis the square wave as following
% sq(t) = 4/pi*\sum_1^N sin((2*n-1)t)/(2*n-1)

t=-10:.001:10;           % time domain
sum = 0;                 % initialise the sum as 0

for n=1:6;             % how many sine components are added
    sum = sum + (sin((2*n-1)*t))/(2*n-1); 
end                     % (2*n-1) is needed to add only the odd sine components
                        
sum = 4/pi*sum;       % Normalize the amplitude
                        
plot(t,sum);
grid on;    
hold on;                

y = square(t);          % Squarewave
plot(t,y,'r');          % Plot squarewave with red colour
