function [b,a,n,fs,x,y,user,xm,xm_old] = f_getfilters (hc_iir,xm,xm_old,fs,F_0,F_1,B,delta_p,...
                                                       delta_s,realize,b,a,x,y,user,hc_type);

%F_GETFILTERS: Compute filter coefficients for GUI module G_FILTERS
%
% Usage: [b,a,n,fs,x,y,user,xm,xm_old] = f_getfilters (hc_iir,xm,xm_old,fs,F_0,F_1,B,delta_p,...
%                                           delta_s,realize,b,a,x,y,user,hc_type);
%
% Inputs: 
%         hc_iir = handle to IIR checkbox
%         xm      = filter type
%
%                   1 = lowpass  
%                   2 = highpass
%                   3 = bandpass
%                   4 = bandstop
%                   5 = user defined
%
%         xm_old   = previous xm
%         fs       = sampling frequency 
%         F_0      = low frequency cutoff (0 to fs/2)
%         F_1      = high frequency cutoff (F_0 to fs/2)
%         B        = transition bandwidth
%         delta_p  = passband ripple (linear)
%         delta_s  = stopband ripple (linear)
%         realize  = filter realization type
%
%                    0 = direct
%                    1 = cascade
%                    2 = lattice (FIR) or parallel (IIR)
%
%         b       = 1 by (n+1) vector of numerator coefficients
%         a       = 1 by (n+1) vector of denominator coefficients
%         x       = M by 1 array of filter inputs
%         y       = M by 1 array of filter outputs
%         user    = string containing name of MAT-file with user-defined
%                   filter paramters a, b, fs
%         hc_type = array of handles to filter type radio buttons        
% Outputs: 
%          b      = 1 by (n+1) vector of numerator coefficients
%          a      = 1 by (n+1) vector of denominator coefficients
%          n      = filter order
%          fs     = sampling frequency 
%          x      = M by 1 array of filter inputs
%          y      = M by 1 array of filter outputs
%          user   = string containing name of MAT-file with user-defined
%                   filter paramters a, b, fs
%          xm     = filter type
%          xm_old = previous xm
%
% Notes: 
%        1. For a lowpass filter, set F_0 = Fc
%        2. For a highpass filter, set F_1 = Fc

iir = get (hc_iir,'Value');

if xm == 5           % user defined
    
   caption = 'Select MAT-file containing a,b,fs';
   [user1,path] = f_getmatfile (caption,user);
   if user1 ~= 0
       user = user1; 
       old_path = pwd;
       cd (path);
       load (user,'a','b','fs')
       cd (old_path)
   else   
       set (hc_type(xm),'Value',0);
       set (hc_type(xm_old),'Value',1);
       xm = xm_old;
   end
   n = length(a)-1;
 
 elseif iir  
     
   switch xm
      
   case 1, 
      F_p = F_0;
      F_s = F_p + B;
   case 2,
      F_p = F_1;
      F_s = F_1 - B;
   case 3,
      F_p = [F_0, F_1];
      F_s = [F_0-B, F_1+B];
   case 4,
      F_p = [F_0-B, F_1+B];
      F_s = [F_0, F_1];
    
   end
   [b,a] = f_butterz   (F_p,F_s,delta_p,delta_s,xm-1,fs);
   n = length(a) - 1;
   
else % FIR
    
    p = [xm-1,F_0,F_1,B];
    m = 50;
    sym = 0;
    win = 2;
    b = f_firwin ('f_firamp',m,fs,win,sym,p);
    a = 1;
    n = length(b)-1;
end 

xm_old = xm;
y =  filter (b,a,x);