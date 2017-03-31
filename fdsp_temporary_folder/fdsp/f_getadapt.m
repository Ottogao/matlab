function [x,d,N,fs,userinput] = f_getadapt (hc_data,x,d,a,b,N,fs,userinput)

%F_GETADAPT: Compute input and desired output for GUM module G_ADAPT
%
% Usage: [x,d,N,fs,userinput] = f_getadapt (data_source,x,d,a,b,N,fs,userinput)
%
% Inputs: 
%         hc_data    = handle to data source checkbox
%         x           = vector of input samples
%         d           = vector of desired output samples
%         a           = vector of denominator coefficients
%         b           = vector of numerator coefficinets
%         N           = number of samples
%         fs          = sampling frequency in Hz 
%         userinput   = string containing name of user-supplied
%                       MAT-file containing x and d
% Outputs: 
%          x         = vector of input samples
%          d         = vector of desired output samples
%          N         = number of samples
%          fs        = sampling frequency in Hz
%          userinput = string containing name of user-supplied
%                      MAT-file containing x and d

% Initialize

data_source = get (hc_data,'Value');
N = f_clip (N,1,N);

% Compute x and d

switch (data_source)
   
case 0,                                          % computed from IIR filter   

   x = f_randu (N,1,-1,1); 
   d = filter (b,a,x);
   
case 1,                                          % load from MAT file
   
   caption = 'Select MAT-file containing x,y,fs';
   [user1,path] = f_getmatfile (caption,userinput);
   if user1 ~= 0
       userinput = user1;
       old_path = pwd;
       cd (path);
       load (userinput,'x','y','fs')
       cd (old_path)
       d = y;
       nd = length(d);
       nx = length(x);
       if nd > nx
           d(nx+1:nd) = [];
       elseif nx > nd
           x(nd+1:nx) = [];
       end
   else
       set (hc_data,'Value',0);
   end
  
end

N = length(x);
 