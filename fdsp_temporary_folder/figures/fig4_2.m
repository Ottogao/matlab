function fig4_2

% FIGURE 4.2:  Segment of recorded vowel "O"
clear
clc
fprintf('Figure 4.2: Segment of recorded vowel ''O''\n\n')

% Get data from microphone and plot it

fname = which('fig4_2.mat');
p = length(fname);
if p > 0
    load(fname)
else
   tau = 1.0;
   fs = 8192;
   y = zeros(tau*fs,1);
   fprintf ('Hold the sound ''oh'' while pressing Start ...\n')
   [y,cancel] = f_getsound (y,tau,fs);
   if cancel
      return
   end
   save fig4_2 y fs
end   

% Dislay results

figure
N = length(y);
T = 1/fs;
t = 1000*[0 : N-1]*T;
k = 1 : N/16;
plot (t(k),y(k))
ymax = 1.2*max(abs(get(gca,'Ylim')));
axis ([t(1),t(N/16),-ymax,ymax])
f_labels ('Mark two consequtive peak points using mouse crosshairs','{\itkT} (msec)','\it{y(k)}')
[x0,y0] = f_caliper(2);

% Play sound and estimate pitch (assuming 5 peak separation)

soundsc (y,fs)
T_0 = x0(2)-x0(1)           % msec
f_0 = 1000/T_0;             % Hz
fprintf ('\nPitch = %.0f Hz\n',f_0)
f_wait
