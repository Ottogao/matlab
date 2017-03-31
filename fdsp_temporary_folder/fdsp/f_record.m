function [x,N,xm,fs] = f_record (x,N,tau,fs,xm,xm_old,hc_type)

%F_RECORD: Record sound as an input vector
%
% Usage: [x,N,xm] = f_record (x,N,tau,fs,xm,xm_old,hc_type)
%
% Inputs: 
%         x    = an array of length N containing input samples
%         N    = number of input samples
%         tau  = duration of recording in seconds
%         fs   = sampling frequency
%         xm   = current value of input type
%         xm_old = previous value of xm
%         hc_type = an array of handles to input type radiou buttons
% Outputs: 
%          x    = an array of length N containing input samples
%          N    = number of input samples
%          xm   = current value of input type
%          fs   = sampling frequency
%
% See also: F_GETSOUND

x_save = x;
N_save = N;
fs_save = fs;
fs = 8192;
xstr = inputname(1);
[x,cancel] = f_getsound (x,tau,fs,xstr);
if cancel
    x = x_save;
    N = N_save;
    fs = fs_save;
    set (hc_type(xm),'Value',0)
    set (hc_type(xm_old),'Value',1)
    xm = xm_old;
end
