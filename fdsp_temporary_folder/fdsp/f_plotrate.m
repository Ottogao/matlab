function f_plotrate (pv,han,fs,hc_dB,L,M,m,c,x,y,b,i_type,f_type,user,fsize)

%F_PLOTRATE: Plot selected view for GUI module G_MULTIRATE
%
% Usage: f_plotrate (pv,han,fs,hc_dB,L,M,m,c,x,y,b,i_type,f_type,user,fsize)
%
% Inputs: 
%         pv      = view selector  
%
%                   1 = time signals (x and y)
%                   2 = magnitude spectra
%                   3 = filter magnitude response
%                   4 = filter phase response
%                   5 = filter impulse response
%
%         han     = array of axes handles
%         fs      = sampling frequency
%         hc_dB   = handle to dB display checkbox)
%         L       = interpolation factor
%         M       = decimation factor
%         m       = filter order
%         c       = input damping factor
%         x       = vector of length N containing input
%         y       = vector of length P containing output
%         b       = vector of length m+1 contain FIR filter coefficients
%         i_type  = input type
%         f_type  = FIR filter type
%         user    = string containing name of user-supplied MAT-file
%                   containing x and fs.
%         fsize   = font size

% Initialize

dB = get(hc_dB,'Value');
colors = get(gca,'ColorOrder');
N = length(x);
P = length(y);
N_max = max(N,P);
f_ploterase (han)

switch f_type
   case 0, caption = sprintf ('L/M = %g, rectangular window filter, m = %d',L/M,m);
   case 1, caption = sprintf ('L/M = %g, Hanning window filter, m = %d',L/M,m);
   case 2, caption = sprintf ('L/M = %g, Hamming window filter, m = %d',L/M,m);
   case 3, caption = sprintf ('L/M = %g, Blackman window filter, m = %d',L/M,m);
   case 4, caption = sprintf ('L/M = %g, frequency-sampled filter, m = %d',L/M,m);
   case 5, caption = sprintf ('L/M = %g, least-squares filter, m = %d',L/M,m);
   case 6, caption = sprintf ('L/M = %g, equiripple filter, m = %d',L/M,m);
end

if (pv <= 2)
   switch i_type
      case 1, caption = ['White noise input, ',caption];
      case 2, caption = ['Damped cosine input, ',caption];
      case 3, caption = ['Amplitude-modulated input, ',caption];
      case 4, caption = ['Frequency-modulated input, ',caption];
      case 5, caption = ['Recorded sound input, ',caption];
      case 6
          user1 = f_cleanstring (user);
          cap1 = sprintf ('User-defined input from file %s, ',user1);
          caption = [cap1 caption];
   end
end

% Plot results

switch pv

case 1,                                               % time signals 

   axes (han(9))
   axis on
   k = 0 : N-1;
   plot(k,x,'Color',colors(1,:))
   if i_type < 5
       axis ([0 N_max -2 2])
   else
      Y_lim = get(gca,'Ylim');
      axis([0 N_max Y_lim(1) Y_lim(2)])
   end
   f_labels (caption,'','x(k)','',fsize)
   axes (han(10))
   axis on
   k = 0 : P-1;
   plot(k,y,'Color',colors(3,:))
   if i_type < 5
      axis ([0 N_max -2 2])
   else
      Y_lim = get(gca,'Ylim');
      axis([0 N_max Y_lim(1) Y_lim(2)])
   end
   f_labels ('','k','y(k)','',fsize)
   
case 2,                                              % magnitude spectra
    
   axes (han(9))
   axis on
   F_max = max(fs,(L/M)*fs); 
   [A_x,Phi_x,S_x,f] = f_spec (x,N,fs);
   i = 1 : N/2+1;
   A_min = 60;

   if dB
       A_x = 20*log10(max(A_x,eps));
       plot (f(i),A_x(i),'Color',colors(1,:))
       Y_lim = get(gca,'Ylim');
       axis([0 F_max/2 Y_lim(1) Y_lim(2)])
       f_labels (caption,'','A_x(f) (dB)','',fsize)
   else
       plot (f(i),A_x(i),'Color',colors(1,:))
       Y_lim = get(gca,'Ylim');
       axis([0 F_max/2 Y_lim(1) Y_lim(2)])
       f_labels (caption,'','A_x(f)','',fsize)
   end
 
   axes (han(10))
   axis on
   [A_y,Phi_y,S_y,f] = f_spec (y,P,(L/M)*fs);
   i = 1 : P/2+1;
   if dB
       A_y = 20*log10(max(A_y,eps));
       plot (f(i),A_y(i),'Color',colors(3,:))
       Y_lim = get(gca,'Ylim');
       axis([0 F_max/2 Y_lim(1) Y_lim(2)])
       f_labels ('','f (Hz)','A_y(f) (dB)','',fsize)
   else
       plot (f(i),A_y(i),'Color',colors(3,:))
       Y_lim = get(gca,'Ylim');
       axis([0 F_max/2 Y_lim(1) Y_lim(2)])
       f_labels ('','f (Hz)','A_y(f)','',fsize)
   end
   
case 3,                                             % magnitude response
    
   axes (han(6))
   axis on
   F_0 = min(fs/(2*L),fs/(2*M));
   a = 1;
   Q = 250;
   [H,f] = f_freqz (b,a,Q,fs);
   A = abs(H);
   p = [0 F_0 F_0 0];
   A_ideal = L*f_firamp (f,fs,p);
   if dB    
      A = 20*log10(max(A,eps));
      A_min = 80;
      plot (f,A,'Color',colors(2,:))
      hold on
      plot (f,20*log10(max(A_ideal,eps)),'k')
      f_labels (caption,'f (Hz)','A(f) (dB)','',fsize)
      axis ([0 fs/2 -A_min 5+20*log10(L)])
      hold off
   else
      plot (f,A,'Color',colors(2,:))
      hold on
      plot(f,A_ideal,'k')
      f_labels (caption,'f (Hz)','A(f)','',fsize)
      axis ([0 fs/2 0 1.2*L])
      hold off
   end
  
case 4,                                               % phase response  
   
   axes (han(6))
   axis on
   a = 1;
   Q = 250;
   [H,f] = f_freqz (b,a,Q,fs);
   phi = angle(H);
   plot (f,phi,'Color',colors(2,:))
   f_labels (caption,'f (Hz)','\phi(f)','',fsize)
   
case 5,                                               % impulse response
   
   axes (han(7))
   axis on
   a = 1;
   hold off
   box off
   delta = [1 zeros(1,m)];
   h = filter (b,a,delta);
   k = [0 : m];
   stem (k,h,'filled','.')
   axis square
   f_labels ('Impulse response','k','h(k)','',fsize)
   axes (han(8))
   f_pzplot (b,a,caption,fsize);
   
end
