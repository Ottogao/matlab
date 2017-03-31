%function DTMF generator
% parameter: the dialed number in a string of digits
function DTMF(dialed)

ltone = [697 770 852 941];
htone = [1209 1336 1477];
fs = 8000;
t=linspace(0,0.1,fs*0.1);   %timeline for one digit
nlen = length(dialed);      %get the length of dialed number
figure(1)
td = linspace(0,2,fs*2);
dtone = cos(2*pi*350*td)+cos(2*pi*440*td);
soundsc(dtone,fs);
for k=1:nlen % go through the numbers
    number = str2num(dialed(k));
    if(number>0)
        lfi = floor(number/3)+1;
        hfi = mod(number-1,3)+1;
    else
        lfi = 4;
        hfi = 2;
    end
    tone = cos(2*pi*ltone(lfi)*t)+cos(2*pi*htone(hfi)*t);
    plot(t,tone);
    soundsc(tone, fs);
    pause(0.1)
end