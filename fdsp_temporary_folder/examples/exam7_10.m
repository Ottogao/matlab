function exam7_10

% Example 7.10: CD-to-DAT sampling rate converter 

clear
clc
fprintf('Example 7.10: CD-to-DAT sampling rate converter\n\n')
f_CD = 44100;
f_DAT = 48000;
L = [8 5 4];
M = [7 7 3];
m = 60;
win = 2;
sym = 0;
fs1 = L(1)*f_CD/M(1);
fs2 = L(2)*fs1/M(2);
fs = [f_CD,fs1,fs2];

% Compute stage filter magnitude responses

stg = f_prompt ('\nCompute stage filters separately (0=no,1=yes)',0,1,0);
if stg
   r = 250;
   for i = 1 : 3
      F(i) = (fs(i)/2)*min(1/L(i),1/M(i));
      p = [0 F(i) F(i) 0];
      b = L(i)*f_firwin ('f_firamp',m,fs(i),win,sym,p);
      [H,f(i,:)] = f_freqz (b,1,r,fs(i));
      A(i,:) = abs(H);
   end
   figure
   plot (f',A','LineWidth',1.5)
   f_labels ('Stage filters','{\itf} (Hz)','\it{A(f)}')
   x = 400;
   text (x,L(1)+.4,'\it{A_1}')
   text (x,L(2)+.4,'\it{A_2}')
   text (x,L(3)+.4,'\it{A_3}')
   f_wait
end

% Sample an input signal at CD rate

d = 2;
x = zeros(d*f_CD,1);
[x,cancel] = f_getsound (x,d,f_CD);
if cancel
    return
end
f_wait ('Press any key to play back sound at 44.1 kHz ...')
soundsc (x,f_CD)
f_wait ('Press any key to play back sound at 48 kHz ...')
soundsc (x,f_DAT)
figure
plot(x);
f_labels ('Use the mouse to select the start of a short speech segment ...','\it{k}','\it{x(k)}')
[k1,x1] = f_caliper(1);

% Convert segment of it to DAT rate

f_wait ('Press any key to rate convert the selected segment...')
p = floor(k1) : floor(k1)+400;
v1 = f_rateconv (x(p),fs(1),L(1),M(1),m,win);
v2 = f_rateconv (v1,fs(2),L(2),M(2),m,win);
y = f_rateconv (v2,fs(3),L(3),M(3),m,win);

% Plot segments

figure
subplot(4,1,1)
k = p - p(1);
plot(k,x(p),'LineWidth',1.5)
f_labels ('','','\it{x(k)}')
subplot(4,1,2)
plot(0:length(v1)-1,v1,'LineWidth',1.5)
f_labels ('','','\it{v_1(k)}')
subplot(4,1,3)
plot(0:length(v2)-1,v2,'LineWidth',1.5)
f_labels ('','','\it{v_2(k)}')
subplot(4,1,4)
plot(0:length(y)-1,y,'LineWidth',1.5)
f_labels ('','\it{k}','\it{y(k)}')
f_wait
