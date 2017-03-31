function f_plotiir (pv,han,fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,xm,proto,n,user,fsize)

%F_PLOTIIR: Plot selected view for GUI module G_IIR
%
% Usage: f_plotiir (pv,han.fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,f_type,proto,n,user,fsize)
%
% Inputs: 
%         pv      = view selector 
%         han     = array of axes handles
%         fs      = sampling frequency
%         F_0     = lower cutoff frequency
%         F_1     = upper cutoff frequency
%         B       = transition bandwidth
%         delta_p = passband ripple
%         delta_s = stopband attenuation
%         hc_dB   = handle of dB display checkbox
%         a       = coefficients of denominator polynomial
%         b       = coefficients of numerator polynomial
%         xm      = filter type
%         proto   = analog prototype filter
%         n       = an optional input specifying the filter order
%         user    = string containing name of MAT-file containing a,b,fs for
%                   user-defined filter
%         fsize   = font size

% Initialize

dB = get(hc_dB,'Value');
colors = get(gca,'ColorOrder');
f_ploterase(han)
f_type = xm-1;

p = 512;
n = length(a)-1;
c = 1;
n = length(a) - 1;
A_p = -20*log10(1-delta_p);
A_s = -20*log10(delta_s);
A = zeros(p,1);
phi = zeros(p,1);
f = linspace (0,fs/2,p);
h = zeros(p,1);

cq = 0;             % no quantization
N = 16;             % number of fixed-point bits
q = c/(2^(N-1));


switch f_type
   
   case 0, caption = sprintf('Resonator filter, n = 2');
   case 1, caption = sprintf('Notch filter, n = 2');    
   case {2,3,4,5},
      
      switch proto
   
         case 1, caption = sprintf('Butterworth filter, n = %d',n);
         case 2, caption = sprintf('Chebyshev-I filter, n = %d',n);
         case 3, caption = sprintf('Chebyshev-II Filter, n = %d',n);
         case 4, caption = sprintf('Elliptic filter, n = %d',n);
            
      end
         
   case 6, 
        user1 = f_cleanstring (user);
        caption = sprintf ('User-defined filter from file %s, n = %d',user1,n);
      
end

% Coefficient quantization

if cq
   a_q = f_quant (a,q,c,0);
   b_q = f_quant (b,q,c,0);
else
   a_q = a;
   b_q = b;
end

if length(a_q) > 1
   r_max = max(abs(roots(a_q)));
else
   r_max = 0;
end
if r_max >= 1
   caption = sprintf ('This filter is unstable (r_{max} = %.3f)',r_max);
end

% Plot results

switch pv
   
case 1,                                               % magnitude response 
   
% Do ideal magnitude response showing design specs

   axes(han(6))
   axis on
   if r_max < 1
      [H,f] = f_freqz (b_q,a_q,p,fs);
      A = abs(H);
   end
   hp(2) = plot([0 fs/2],[0 0],'k');
   axis ([0 fs/2 0 1])
   hold on
   if dB
      A = 20*log10(max(A,eps));
      f_labels (caption,'f (Hz)','A(f) (dB)','',fsize)
      A_min = 2*A_s;
      axis ([0 fs/2 -A_min 0])
   else
      f_labels (caption,'f (Hz)','A(f)','',fsize)
      axis ([0 fs/2 0 1])
   end
   
   switch f_type
   case {2,3,4,5},
      
      if f_type == 2
         if dB
            fill ([0 F_0 F_0 0],[-A_p -A_p 0 0],'c')
            fill ([F_0+B fs/2 fs/2 F_0+B],[-A_min -A_min -A_s -A_s],'c')
         else
            fill ([0 F_0 F_0 0],[1-delta_p 1-delta_p 1 1],'c')
            fill ([F_0+B fs/2 fs/2 F_0+B],[0 0 delta_s delta_s],'c')
         end
      end
     
      if f_type == 3
         if dB
            fill ([F_1 fs/2 fs/2 F_1],[-A_p -A_p 0 0],'c')
            fill ([0 F_1-B F_1-B 0],[-A_min -A_min -A_s -A_s],'c')
         else
            fill ([F_1 fs/2 fs/2 F_1],[1-delta_p 1-delta_p 1 1],'c')
            fill ([0 F_1-B F_1-B 0],[0 0 delta_s delta_s],'c')
         end
      end
      
      if f_type == 4
         if dB
            fill ([0 F_0-B F_0-B 0],[-A_min -A_min -A_s -A_s],'c')
            fill ([F_0 F_1 F_1 F_0],[-A_p -A_p 0 0],'c')
            fill ([F_1+B fs/2 fs/2 F_1+B],[-A_min -A_min -A_s -A_s],'c')
         else
            fill ([0 F_0-B F_0-B 0],[0 0 delta_s delta_s],'c')
            fill ([F_0 F_1 F_1 F_0],[1-delta_p 1-delta_p 1 1],'c')
            fill ([F_1+B fs/2 fs/2 F_1+B],[0 0 delta_s delta_s],'c')
         end
      end
      
      if f_type == 5
         if dB
            fill ([0 F_0-B F_0-B 0],[-A_p -A_p 0 0],'c')
            fill ([F_0 F_1 F_1 F_0],[-A_min -A_min -A_s -A_s],'c')
            fill ([F_1+B fs/2 fs/2 F_1+B],[-A_p -A_p 0 0],'c')
         else
            fill ([0 F_0-B F_0-B 0],[1-delta_p 1-delta_p 1 1],'c')
            fill ([F_0 F_1 F_1 F_0],[0 0 delta_s delta_s],'c')
            fill ([F_1+B fs/2 fs/2 F_1+B],[1-delta_p 1-delta_p 1 1],'c')
         end
      end
      
   end
   hp(1) = plot (f,A,'Color',colors(2,:),'LineWidth',1.5);
   
   % Add legend

   legpos = [1 1 1 2 1 4 1];
   hl = legend (hp,'IIR filter','Ideal',legpos(f_type+1));
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   hold off

case 2,                                               % phase response  
   
   axes(han(6))
   axis on
   if r_max < 1
      [H,f] = f_freqz (b_q,a_q,p,fs);
      phi = angle(H);
   end
   plot (f,phi,'Color',colors(2,:))
   f_labels (caption,'f (Hz)','\phi','',fsize)
   
   
case 3                                               % pole-zero plot
  
   axes (han(7))
   f_pzplot (b_q,a_q,caption,fsize);
   axes (han(8))
   axis on
   hold off 
   box off
   f_impulse (b_q,a_q,p,64,0,1,'Impulse response',fsize);
 
case 4                                             % impulse response
  
   axes (han(7))
   axis on
   hold off
   box off
   f_impulse (b_q,a_q,p,64,0,1,'Impulse response',fsize);
   axes (han(8))
   f_pzplot (b_q,a_q,caption,fsize);
 
end
