function [x,y,b,fs,user,xm,xm_old] = f_getrate (xm,xm_old,fs,L,M,c,m,f_type,user,x,y,hc_type);

%F_GETRATE: Compute input and output for GUI module G_MULTIRATE
%
% Usage: [x,y,b,fs,user,xm,xm_old] = f_getrate (xm,xm_old,fs,L,M,c,m,f_type,user,x,y,hc_type);
%
% Inputs: 
%         xm      = input type
%
%                   1 = white noise  
%                   2 = damped cosine
%                   3 = amplitude modulated (AM)
%                   4 = frequency modulated (FM)
%                   5 = record sound
%                   6 = user defined
%
%         xm_old  = previous xm
%         fs      = sampling frequency 
%         L       = interpolation factor (1 to 100)
%         M       = decimation factor (1 to 100)
%         c       = damping factor
%         m       = FIR filter order 
%         f_type  = FIR filter type
%
%                   0 = windowed (rectangular)
%                   1 = windowed (Hanning)
%                   2 = windowed (Hamming)
%                   3 = windowed (Blackman)
%                   4 = frequency-sampled
%                   5 = least-squares
%                   6 = equiripple 
%
%         user    = string containing name of MAT-file that
%                   contains input x and samping frequency fs
%         x       = 1 by N vector containing current input samples
%         y       = 1 by P vector containing current output samples
%         hc_type = array of handles to input type radio buttons
% Outputs: 
%          x      = 1 by N vector containing input samples
%          y      = 1 by P vector containing output samples where
%                   P = floor(L*N/M);
%          b      = 1 by m+1 coefficient vector for FIR filter
%          fs     = sampling frequency
%          user   = string containing name of MAT-file that
%                   contains input x and samping frequency fs
%          xm     = input type
%          xm_old = previous xm

% Initialize

N = length(x);
T = 1/fs;

% Construct input
 
switch (xm)
   
case 1,                                          % white noise
   
    clear x
    N = 1000;
    x = f_randu (N,1,-1,1);
   
case 2,                                          % damped cosine
   
   clear x
   N = 500;
   F_0 = fs/10;
   k = 0 : N-1;
   x = c.^k .* cos(2*pi*F_0*k*T);
      
case 3,                                          % amplitude modulated (AM)
   
   clear x
   N = 1500;
   F_0 = fs/180;
   F_1 = 32*F_0;
   k = 0 : N-1;
   x = sin(2*pi*F_0*k*T) .* cos(2*pi*F_1*k*T);
   
case 4,                                          % frequency mopdulated (FM)
   
   clear x
   N = 1500;
   F_0 = fs/80;
   F_1 = 4*F_0;
   k = 0 : N-1;
   f = F_0 + (F_1-F_0)*sin(4*pi*k*T);
   x = cos(2*pi*f.*k*T);
   
case 5,                                          % record x
   
   [x,N,xm,fs] = f_record (x,N,1.0,fs,xm,xm_old,hc_type);
   
case 6,                                          % user defined
   
   caption = 'Select MAT-file containing x,fs';
   [user1,path] = f_getmatfile (caption,user); 
   if user1 ~= 0
       user = user1;
       old_path = pwd;
       cd (path);
       load (user,'x','fs')
       cd (old_path)
   else   
       set (hc_type(xm),'Value',0);
       set (hc_type(xm_old),'Value',1);
       xm = xm_old;
   end

end

% Check x and compute y using rate conversion

xm_old = xm;
x = f_tocol(x);
[y,b] = f_rateconv (x,fs,L,M,m,f_type);
