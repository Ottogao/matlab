function b = f_firideal (f_type,F,m,fs,win)

%F_FIRIDEAL Designs an ideal linear-phase frequency-selective windowed FIR filter
%
% Usage: b = f_firideal (f_type,F,m,fs,win)
%
% Inputs: 
%         f_type = integer selecting the frequency-selective filter type
%
%                  0 = lowpass
%                  1 = highpass
%                  2 = bandpass
%                  3 = bandstop
%
%         F      = scalor or vector of length two containing the 
%                  cutoff frequency or frequencies.
%         m      = filter order (even)
%         fs     = sampling frequency
%         win    = the window type to be used:
%
%                  0 = rectangular
%                  1 = Hanning
%                  2 = Hamming
%                  3 = Blackman
% Outputs: 
%          b   = 1 by m+1 vector of filter coeficients. The 
%                filter output is
%
%                y(k) = b[1]*x[k] + b[2]*x[k-1] + ... + b[m+1]*x[k-m]  
%   
% See also: F_FIRWIN, F_FIRSAMP, F_FIRLS, F_FIRPARKS, F_FREQZ    

% Initialize

f_type = f_clip(f_type,0,3);
m = f_clip(m,0,m);
p = floor(m/2);
m = 2*p;
win = f_clip(win,0,3);
b = zeros (1,m+1);
F_0 = F(1);
if f_type > 1
    F_1 = F(2);
end
T = 1/fs;

switch f_type
    
    case 0,                                 % lowpass
    
        for k = 0 : m
           if k ==  p
               b(k+1) = 2*F_0*T;
           else
               k1 = pi*(k - p);
               b(k+1) = sin(2*k1*F_0*T)/k1;
           end
        end

    case 1,                                 % highpass
    
        for k = 0 : m
           if k ==  p
               b(k+1) = 1 - 2*F_0*T;
           else
               k1 = pi*(k - p);
               b(k+1) = -sin(2*k1*F_0*T)/k1;
           end
        end
    
    case 2,                                 % bandpass
    
        for k = 0 : m
           if k ==  p
               b(k+1) = 2*(F_1 - F_0)*T;
           else
               k1 = pi*(k - p);
               b(k+1) = (sin(2*k1*F_1*T) - sin(2*k1*F_0*T))/k1;
           end
        end
    
    case 3,                                 % bandstop
    
        for k = 0 : m
           if k ==  p
               b(k+1) = 1 - 2*(F_1 - F_0)*T;
           else
               k1 = pi*(k - p);
               b(k+1) = (sin(2*k1*F_0*T) - sin(2*k1*F_1*T))/k1;
           end
        end
    
end
 
% Add window

w = f_window (win,m);
b = b .* w;
b = real(b);
