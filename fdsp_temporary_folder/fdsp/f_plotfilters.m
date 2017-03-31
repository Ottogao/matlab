function f_plotfilters (pv,han,cq,N,fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,hc_iir,xm,realize,user,fsize)

%F_PLOTFILTERS: Plot selected view for GUI module G_FILTERS
%
% Usage: f_plotfilters (pv,han,cq,N,fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,hc_iir,xm,realize,user,fsize)
%
% Inputs: 
%         pv      = view selector
%         han     = array of axes handles
%         cq      = coefficient quantization switch (0 = not quantized)
%         N       = number of fixed point bits
%         fs      = sampling frequency
%         F_0     = lower cutoff frequency
%         F_1     = upper cutoff frequency
%         B       = transition bandwidth
%         delta_p = passband ripple
%         delta_s = stopband attenuation
%         hc_dB   = handle to dB display checkbox
%         a       = coefficients of denominator polynomial
%         b       = coefficients of numerator polynomial
%         hc_iir  = handle to IIR checkbox 
%         xm      = filter type
%         realize = filter realizaton form
%         user    = string containing name of MAT-file speciyfing
%                   user-defined filter: a, b, fs
%         fsize   = font size

% Initialize

dB = get (hc_dB,'Value');
iir = get (hc_iir,'Value');
f_ploterase (han)
axes (han(6))
axis on

colors = get(gca,'ColorOrder');
p = 512;
n = length(a)-1;
m = length(b)-1;
A_p = -20*log10(1-delta_p);
A_s = -20*log10(delta_s);
A = zeros(p,1);
phi = zeros(p,1);
f = linspace (0,fs/2,p);
h = zeros(p,1);

% Coefficient quantization

c = max(abs([a(:) ; b(:)]));
c = 2^(ceil(log(c)/log(2)));
q = c/(2^(N-1));
a_q = f_quant (a,q,0);
b_q = f_quant (b,q,0);
if length(a_q) > 1
   r_max = max(abs(roots(a_q)));
else
   r_max = 0;
end
if r_max >= 1
   caption = sprintf ('The quantized filter is unstable: r_{max}=%.3f, c=%d, q=%g',r_max,c,q);
   
elseif xm == 5
    user1 = f_cleanstring (user);
    switch realize
        case 0,
            caption = sprintf ('Direct user-defined filter from file %s: n=%d, m=%d, c=%d, q=%g',user1,n,m,c,q);
        case 1,  
            caption = sprintf ('Cascade user-defined filter from file %s: n=%d, m=%d, c=%d, q=%g',user1,n,m,c,q);
    end
else
    if iir
        switch realize
            case 0,
                caption = sprintf('Direct Butterworth IIR filter: n=%d, m=%d, c=%d, q=%g',n,m,c,q);
            case 1,
                caption = sprintf('Cascade Butterworth IIR filter: n=%d, m=%d, c=%d, q=%g',n,m,c,q);
        end   
    else
        switch realize
            case 0,
                caption = sprintf('Direct windowed FIR filter: m=%d, c=%d, q=%g',m,c,q);
            case 1,
                caption = sprintf('Cascade windowed FIR filter: m=%d, c=%d, q=%g',m,c,q);
        end   
    end
end

% Plot results

switch pv
   
case 1,                                               % magnitude response 
   
% Do magnitude responses showing design specs

   [H,f] = f_freqz (b,a,p,fs);
   A = abs(H);
   if r_max < 1
      [H_q,f] = f_freqz (b,a,p,fs,N,realize);
      A_q = abs(H_q);
   else
      A_q = zeros(size(f));
   end
   hp = plot (f,A,f,A_q);
   set (hp(1),'LineWidth',1.5)
   hold on
   if dB
      A = 20*log10(max(A,eps));
      A_q = 20*log10(max(A_q,eps));
      f_labels ('','f/f_s','A(f) (dB)','',fsize)
      A_min = 2*A_s;
      if (xm < 5)
         axis ([0 fs/2 -A_min 0])
      end
   else
      f_labels ('','f/f_s','A(f)','',fsize)
      if (xm < 5)
         axis ([0 fs/2 0 1.5])
      else
         A_max = max(max(A),max(A_q));
         if (abs(A_max - 1) < 0.01)
            axis ([0 fs/2 0 1.5])
         end
      end
   end
   
   switch xm
   case {1,2,3,4},
      
      if xm == 1
         if dB
            fill ([0 F_0 F_0 0],[-A_p -A_p 0 0],'c')
            fill ([F_0+B fs/2 fs/2 F_0+B],[-A_min -A_min -A_s -A_s],'c')
         else
            fill ([0 F_0 F_0 0],[1-delta_p 1-delta_p 1 1],'c')
            fill ([F_0+B fs/2 fs/2 F_0+B],[0 0 delta_s delta_s],'c')
         end
      end
     
      if xm == 2
         if dB
            fill ([F_1 fs/2 fs/2 F_1],[-A_p -A_p 0 0],'c')
            fill ([0 F_1-B F_1-B 0],[-A_min -A_min -A_s -A_s],'c')
         else
            fill ([F_1 fs/2 fs/2 F_1],[1-delta_p 1-delta_p 1 1],'c')
            fill ([0 F_1-B F_1-B 0],[0 0 delta_s delta_s],'c')
         end
      end
      
      if xm == 3
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
      
      if xm == 4
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
   hp = plot (f,A,f,A_q);
   set (hp(1),'LineWidth',1.5)
   qstr = sprintf ('Quantized, N = %d',N);
   hl = legend ('Unquantized',qstr);
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   plot([0 fs/2],[0 0],'k')
   if ~dB
       caption = [caption sprintf(', e_{max} = %g',max(abs(A-A_q)))];
   end
   title (caption,'FontName','FixedWidthFontName','FontSize',fsize)
   hold off
   
case 2,                                               % phase response  
   
   [H,f] = f_freqz (b,a,p,fs);
   phi = angle(H);
   if r_max < 1
       [H_q,f] = f_freqz (b,a,p,fs,N,realize);
       phi_q = angle(H_q);
   else
       phi_q = zeros(size(f));
   end
   qstr = sprintf ('Quantized, N = %d',N);
   hp = plot (f,phi,f,phi_q);
   set (hp(1),'LineWidth',1.5)
   hl = legend ('Unquantized',qstr);    
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   f_labels (caption,'f/f_s','\phi','',fsize)
   hold off
   
case 3,                                               % pole-zero plot
   
   axes (han(6))
   cla
   f_labels ('','','',fsize)
   axis off
   axes (han(7))
   fsize
   f_pzplot (b,a,'Unquantized pole-zero plot',fsize);
   axes (han(8))
   cap = sprintf ('Quantized pole-zero plot: N = %d',N);
   f_pzplot (b_q,a_q,cap,fsize);
   hold off
   
case 4,                                               % impulse response

   axes (han(6))
   axis off
   axes (han(7))
   axis on
   hold off 
   box off
   f_impulse (b,a,p,64,realize,1,'Impulse response',fsize);
   axes (han(8))
   axis on
   hold off
   caption = sprintf ('Quantized impulse response: N = %d',N);
   f_impulse (b,a,p,N,realize,1,caption,fsize);
   hold off
   
case 5,                                               % quantizer
   
   x0 = linspace (-c,c,2*p);
   y0 = f_quant (x0,q,0);
   y0 = min(y0,c-q);
   plot (x0,y0,'LineWidth',1.5)
   hold on
   plot ([-c,c],[0 0],'k',[0 0],[-c c],'k')
   axis ([-c c -c c])
   caption = sprintf ('Quantizer input-output characteristic: c=%d, N=%d, q=%g',c,N,q);
   f_labels (caption,'x','Q_N(x)','',fsize)
   hold off
   
end
