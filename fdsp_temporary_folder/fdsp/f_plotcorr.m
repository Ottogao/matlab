function f_plotcorr (pv,han,x,y,hc_circ,hc_norm,xm,userinput,fs,fsize);

%F_PLOTCORR: Plot selective view for GUI module G_CORRELATE
%
% Usage: f_plotcorr (pv,han,x,y,hc_circ,hc_norm,xm,userinput,fs,fsize)
%
% Inputs: 
%         pv        = view selection
%         han       = array of axes handles 
%         x         = input signal x
%         y         = input signal y
%         hc_circ   = handle to circular checkbox
%         hc_norm   = handle to normaliazed checkbox
%         xm        = input type
%         userinput = string containing name MAT-file containing user-defined
%                     input 
%         fs        = sampling frequency of x and y
%         fsize     = font size

% Initialize

circ = get (hc_circ,'Value');
norm = get (hc_norm,'Value');
f_ploterase (han)
axes (han(6))
axis on
colors = get(gca,'ColorOrder');
L = length(x);
M = length(y);

% Construct title

prefex = (circ & (pv >= 2) & (pv <= 4)) | ... 
         (norm & (pv >= 3) & (pv <= 4));

switch pv
    
    case 1, s1 = 'Inputs x and y: ';
        
    case 2, 
        
       if (circ & (pv >= 3) & (pv <= 5))
           s1 = 'convolution: ';
       else
           s1 = 'Convolution: ';
       end
       
    case 3, 
        
       if prefex
           s1 = 'cross-correlation: ';
       else
           s1 = 'Cross-correlation: ';
       end
       
    case 4, 
        
       if prefex
           s1 = 'auto-correlation of x(k): ';
       else
           s1 = 'Auto-correlation of x(k): ';
       end
       
    case 5, s1 = 'Power density spectrum: ';   

end
 
switch xm
    
    case 1, s2 = 'white noise input';
    case 2, s2 = 'periodic input';
    case 3, s2 = 'impulse train input';
    case 4, s2 = 'recorded sound input';
    case 5,
        user1 = f_cleanstring (userinput);
        s2 = sprintf ('user-defined inputs from file %s',user1);
end

% Create title

if circ & (pv >= 2) & (pv <= 4)
    if norm & (pv >= 3) & (pv <= 4)
         s1 = ['circular ' s1];
     else
         s1 = ['Circular ' s1];
     end
end
if norm & (pv >= 3) & (pv <= 4)
    s1 = ['Normalized ' s1];
end
title = [s1 s2];

% Compute and plot result   

switch (pv)
      
case 1,					% Inputs x and y

   axes(han(6))
   axis off
   axes (han(9))
   axis on
   k = 0 : L-1;
   plot (k,x(k+1),'Color',colors(1,:));
   xlim = get (han(9),'XLim');
   f_labels (title,'','x(k)','',fsize);
   axes (han(10))
   axis on
   k = 0 : M-1;
   plot (k,y(k+1),'Color',colors(2,:));
   ylim = get (han(10),'YLim');
   axis ([xlim(1) xlim(2) ylim(1) ylim(2)]) 
   f_labels ('','k','y(k)','',fsize);
   
case 2,					% Convolution
   
   r = f_conv(x,y,circ);
   k = 0 : length(r)-1;
   plot (k,r,'Color',colors(3,:));
   if circ
      ylabel = 'x(k) \circ y(k)';
   else
      ylabel = 'x(k) * y(k)';
   end
   f_labels (title,'k',ylabel,'',fsize)
   
case 3,					% Cross-correlation
   
   if circ
       r = f_corr(x(1:M),y,circ,norm);
       k = 0 : M-1;
   else
       r = f_corr(x,y,circ,norm);
       k = 0 : L-1;
   end
   plot (k,r,'Color',colors(3,:));
   if circ
      if norm
         ylabel = '\sigma_{xy}(k)';
      else
         ylabel = 'c_{xy}(k)';
      end
   else
      if norm
         ylabel = '\rho_{xy}(k)';
      else
         ylabel = 'r_{xy}(k)';
      end
   end
   f_labels (title,'k',ylabel,'',fsize)
   
case 4,					% Auto-correlation
   
   k = 0 : L-1;
   r = f_corr(x,x,circ,norm);
   plot (k,r,'Color',colors(3,:));
   if circ
      if norm
         ylabel = '\sigma_{xx}(k)';
      else
         ylabel = 'c_{xx}(k)';
      end
   else
      if norm
         ylabel = '\rho_{xx}(k)';
      else
         ylabel = 'r_{xx}(k)';
      end
   end
   f_labels (title,'k',ylabel,'',fsize)
   

case 5,					% Power density spectrum of x

   f = linspace (0,(L-1)*fs/L,L)';
   c_xx = f_corr (x,x,1,0);
   C_xx = real(fft(c_xx));
   i = 1 : floor(L/2) + 1;
   plot (f(i),C_xx(i),'Color',colors(3,:));
   f_labels (title,'f (Hz)','S_L(f)','',fsize)
   
end
