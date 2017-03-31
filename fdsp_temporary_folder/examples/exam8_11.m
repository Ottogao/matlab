function exam8_11

% Example 8.11: Reverb filter 

clear
clc
fprintf('Example 8.11: Reverb filter\n\n')

% Plot impulse response

fs = 8000;
N = 8192;
x = [1,zeros(1,N-1)];
y = x;
[h,n] = f_reverb(x,fs);
n
figure
plot ([1:N-1],h(2:N))
f_labels ('Impulse response','\it{k}','\it{h(k)}')
f_wait

% Plot magnitude response

H = fft(h);
A = abs(H);
f = linspace (0,(N-1)*fs/N,N);
figure
plot (f(1:N/2),A(1:N/2))
f_labels ('Magnitude response','{\itf} (Hz)','\it{A(f)}')
f_wait

% Get sound and put it through reverb filter

tau = 3.0;
choice = 0;
p = floor(8000/tau);
z = zeros(p,1);
while choice ~= 4
   choice = menu ('Please select one','record sound','play back (normal)',...
                  'play back (reverb)','exit');
   switch (choice)
   case 1, 
      [z,cancel] = f_getsound (z,tau,fs);
      if ~cancel
          y = f_reverb (z,fs);
      end
   case 2, 
      soundsc (z,fs)
   case 3, 
      soundsc (y,fs);
   end
end
