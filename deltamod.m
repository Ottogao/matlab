% Delta modulation demostration 
% according to the theory, the overload problem will occur
% when the sampling frequency is set as fs < 2*pi*f*A/delta
% put it in our simulation code, A=1, f=1, delta=0.1, so
% if fs is set less than 62Hz then we will see output overload

clf
clear all
t=linspace(0,1,10000);   % time resolution of a sin wave
f=1;                % frequency
delta = 0.1;        % amplitude increament/decreament (i.e., delta)
fs = 100;           % sampling frequency
dac = 0;            % dac initial output
st = sin(2*pi*f*t); % input signal
sp = (0:(fs-1))*10000/fs +1 ;   % sampling times %(1:fs)*10000/fs;
samples = st(sp);   % take samples from input signal
b(1) = 0;           % prepare for 1-bit ADC output
outp(1)=0;          % output of DAC, increamenting or decreamenting
for k=1:fs          % apply the correct policy.
    if samples(k)>=dac
        b(k) = 1;
        dac = dac + delta;
    else
        b(k) = 0;
        dac = dac - delta;
    end
    outp(k) = dac;
end
% for k=1:(fs-1)           % apply the wrong policy.
%     if samples(k+1)>=samples(k)
%         b(k+1) = 1;
%         dac = dac + delta;
%     else
%         b(k+1) = 0;
%         dac = dac - delta;
%     end
%     outp(k+1) = dac;
% end

subplot(2,1,1);
plot(t, st, 'b');
hold on
%stairs(sp/10000,samples,'m');
stairs(sp/10000, outp, 'r')

hold off
subplot(2,1,2);
stairs(sp/10000, b,'g')
axis([0 1 -1 2])