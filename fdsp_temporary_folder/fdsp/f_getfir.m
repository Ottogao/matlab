function [b,a,m,fs,x,y,user,xm,xm_old] = f_getfir (xm,xm_old,fs,F_0,F_1,B,delta_p,delta_s,m,method,...
                                         win,user,b,a,x,y,hc_type);

%F_GETFIR: Compute FIR filter coefficients for GUI module G_FIR
%                            
% Usage: [b,a,m,fs] = f_getiir(xm,fs,F_0,F_1,B,delta_p,delta_m,m,method,...
%                              win,user,b,a,x,y);
%
% Inputs: 
%         xm      = filter type
%
%                   1 = lowpass  
%                   2 = highpass
%                   3 = bandpass
%                   4 = bandstop
%                   5 = user-defined
%
%         xm_old  = previous xm
%         fs      = sampling frequency 
%         F_0     = low frequency cutoff (0 to fs/2)
%         F_1     = high frequency cutoff (F_0 to fs/2)
%         B       = transition bandwidth    
%         delta_p = passband ripple factor
%         delta_s = stopband attenuation factor  
%         m       = filter order
%         method  = filter design method to use
%
%                   0 = windowed (rectangular)
%                   1 = windowed (Hanning)
%                   2 = windowed (Hamming)
%                   3 = windowed (Blackman)
%                   4 = frequency sampled
%                   5 = least-squares
%                   6 = equiripple 
%
%         win     = window type (0 to 3, ... see f_window)
%         user    = string containing name of M-file that
%                   specifies desired magnitude response
%                   (no .m).
%         b       = 1 by (n+1) vector of numerator coefficients
%         a       = 1 by (n+1) vector of denominator coefficients
%         x       = M by 1 array of filter inputs
%         y       = M by 1 array of filter ouputs 
%         hc_type = array of handles to filter type radio buttons
% Outputs: 
%          b       = 1 by (n+1) vector of numerator coefficients
%          a       = 1 by (n+1) vector of denominator coefficients
%          m       = filter order
%          fs      = sampling frequency 
%          x       = M by 1 array of filter inputs
%          y       = M by 1 array of filter ouputs 
%          user    = string containing name of M-file that
%                    specifies desired magnitude response
%                    (no .m).
%          xm      = filter type
%          xm_old  = previous  xm

% Initialize

f_type = xm-1;
sym = 0;
a = 1;
B = min([B,F_0,fs/2-F_1]);
p = [f_type F_0 F_1 B];
switch method
   
case 4,
   m1 = floor(m/2);
   i = 0 : m1;
   F = i*fs/(2*m1+1);
   A = f_firamp (F,fs,p);
case 5,
   i = 0 : m;
   F = i*fs/(2*m);
   A = f_firamp (F,fs,p);
   w = ones(size(A));
case 6,
   switch f_type
       case 0,
           F_p = F_0;
           F_s = F_0 + B;
       case 1,
           F_p = F_1;
           F_s = F_1-B;
       case 2,
           F_p = [F_0, F_1];
           F_s = [F_0-B, F_1+B];
       case 3,
           F_p = [F_0-B,F_1+B];
           F_s = [F_0, F_1];
   end
end

% Construct fitler

switch (f_type)
   
case {0,1,2,3},                                             
   
   switch method
      
      case {0,1,2,3}, b = f_firwin ('f_firamp',m,fs,method,sym,p);
      case 4, b = f_firsamp (A,m,fs,sym);
      case 5, b = f_firls   (F,A,m,fs,w);
      case 6, b = f_firparks (m,F_p,F_s,delta_p,delta_s,f_type,fs);    
      
   end
   
case 4,                                          % User-defined
   
   user1 = f_getfun (user,'Select amplitude response M-file function');

% Check for incompatible user functions

   s = lower(user1);
   if strcmp(s,'u_sample1.m') | strcmp(s,'u_sample1') | ... 
      strcmp(s,'u_reconstruct1.m') | strcmp(s,'u_reconstruct1')

       msg = {'The M-file functions u_sample1 and u_reconstruct1 are functions of t.',
              'The user-defined M-file function for g_fir must be a function of (f,fs).'
              'See file u_fir1.m for an example.'};
       button = questdlg (msg,'User-defined M-file function warning','Ok','Ok');   
       user1 = 'u_fir1';    
   end

 %  Design user-defined filter
   
   if ~isequal(user1,0)
       user = user1; 
       switch method
       case {0,1,2,3}, 
           b = f_firwin (user,m,fs,method,sym);
       case 4,
           A = feval(user,F,fs);
           b = f_firsamp (A,m,fs,sym);
       case 5,
           A = feval(user,F,fs);
           b = f_firls (F,A,m,fs,w);
       case 6,
           msg = {'The Equiripple design method is only applicable to the  basic filter types ',...
                  '(lowpass, highpass, bandpass, bandstop).  For a general User-defined ',...
                  'filter, please choose a different filter design method (windowed, '...
                  'frequency-sampled, or least-squares).'}; 
           button = questdlg (msg,'User-defined filter warning','Ok','Ok'); 
           
       end
   else
       set (hc_type(xm),'Value',0);
       set (hc_type(xm_old),'Value',1);
       xm = xm_old;
   end
end
 
xm_old = xm;
y = filter(b,a,x);