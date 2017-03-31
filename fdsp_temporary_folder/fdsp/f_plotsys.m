function y = plotsys (pv,han,xm,N,fs,hc_dB,a,b,x,c,f0,userinput,hc_stem,fsize)

%F_PLOTSYS: Plot selected view for GUI module G_SYSTEM
%
% Usage: y = plotsys (pv,han,xm,N,fs,hc_dB,a,b,x,c,f0,hc_stem,fsize)
%
% Inputs: 
%         pv        = view selection (1 to 4)
%         han       = array of axes handles
%         xm        = input selection (1 to 6)
%         N         = number of samples
%         fs        = sampling frequency
%         hc_dB     = handle to decibel display selector
%         a         = coefficients of denominator polynomial
%         b         = coefficients of numerator polynomial
%         x         = 1 by N vector of input samples
%         c         = damping factor for cosine input
%         f0        = frequency of cosine input (0 to fs/2)
%         userinput = string containing name of user-defined
%                     MAT-file when xm = 6
%         hc_stem   = handle to stem plot display selector
%         fsize     = font size
% Outputs: 
%          y = 1 by N vector of output samples

% Initialize

dB = get(hc_dB,'Value');
stem_plot = get(hc_stem,'Value');
f_ploterase (han)
axes (han(6))
axis on
r = max(abs(roots(a)));

% Construct title

switch pv
    
    case 1, s1 = 'Time signals, ';
        
end

switch xm,
   case 1, s2 = 'white noise input';
   case 2, s2 = 'unit impulse input';
   case 3, s2 = 'unit step input';
   case 4, s2 = sprintf('damped cosine input: c=%g, f_0=%g',c,f0);
   case 5, s2 = 'recorded sound input';
   case 6,
        user1 = f_cleanstring (userinput);
        s2 = sprintf ('user-defined input from file %s',user1);
end
if pv <= 1
   caption = [s1 s2];
   if (r > 1)
       caption = [caption ' (unstable system)'];
   end
end

% Compute system output

k = [0 : N-1];
y = filter (b,a,x);

% Plot results

f_ploterase (han);
colors = get(gca,'ColorOrder');
switch pv
case 1,                                               % time signals     

   axes (han(9))
   axis on
   if stem_plot
       hp = stem (k,x(1:N),'filled','.');
       set (hp,'Color',colors(1,:));
   else
      plot(k,x(1:N),'Color',colors(1,:));
   end

   f_labels (caption,'','x(k)','',fsize)
   
   axes (han(10))
   axis on
   if stem_plot
       hp = stem (k,y(1:N),'filled','.');
       set (hp,'Color',colors(3,:));
   else
       plot(k,y(1:N),'Color',colors(3,:));
   end
   f_labels ('','k','y(k)','',fsize)
       
case 2,                                               % magnitude response 
   
   axes (han(6))
   axis on
   [H,f] = f_freqz (b,a,N,fs);
   if (dB == 1)
      A = 20*log10(max(abs(H),eps));
   else
      A = abs(H);
   end
   plot (f,A,'Color',colors(2,:))
   caption = 'Magnitude response';
   if r > 1
       caption = [caption ' (unstable system)'];
   end
   if (dB == 1)
      f_labels (caption,'f (Hz)','A(f) (dB)','',fsize)
   else   
      f_labels (caption,'f (Hz)','A(f)','',fsize)
   end
   
case 3,                                               % phase response  
   
   axes (han(6))
   axis on
   [H,f] = f_freqz (b,a,N,fs);
   phi = angle(H);
   plot (f,phi,'Color',colors(2,:))
   caption = 'Phase response';
   if r > 1
       caption = [caption ' (unstable system)'];
   end
   f_labels (caption,'f (Hz)','\phi','',fsize)
   
case 4,                                               % pole-zero plot
   
   axes (han(6))
   cla
   f_labels ('','','',fsize)
   axis off
   axes (han(7))
   f_pzplot (b,a,'',fsize);
   axes (han(8))
   f_pzsurf (b,a,10,41,'',fsize,dB)
    
end
