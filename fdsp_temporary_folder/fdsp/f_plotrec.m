function plotrec (pv,haxis,hfs,xm,n,Fc,N,Vr,userinput,fsize)

%F_PLOTREC: Plot selected view for GUI module G_RECONSTRUCT
%
% Usage: plotrec (pv,haxis,hfs,xm,n,Fc,N,Vr,userinput,fsize)
%
% Inputs: 
%         pv        = view selection (1 to 3)
%         haxis     = handle to axes for plot
%         hfs       = handle to the fs slider
%         xm        = input selection (0 to 5)
%         n         = anti-aliasing filter order (0 = no filter)
%         Fc        = anti-aliasing filter cutoff frequency
%         N         = DAC precision (bits)
%         Vr        = DAC reference voltage
%         userinput = string specifying a user defined input
%                     M-file function: x = userinput(t)
%         fsize     = font size 

hold off
axes (haxis)
cla
fs = floor(get(hfs(1),'Value'));
colors = get(gca,'ColorOrder');
j = sqrt(-1);
if n > 0
   [b,a] = f_butters (Fc,Fc+1,.1,.1,n); 
end
T = 1/fs;

% Construct title

switch pv
    
    case 1, s1 = 'Time signals, ';
    case 2, s1 = 'Magnitude spectra, ';
        
end
 
switch xm
    
    case 1, s2 = 'consant input';
    case 2, s2 = 'damped exponential input';
    case 3, s2 = 'cosine input';
    case 4, s2 = 'square wave input';
    case 5,
        user1 = f_cleanstring (userinput);
        s2 = sprintf ('user-defined input from file %s',user1);
end
s3 = sprintf(': N=%d, V_r=%g, n=%d, F_c=%g, f_s=%g',N,Vr,n,Fc,fs);
if pv <= 2
   caption = [s1 s2 s3];
end

if (pv == 1)
   
% Plot time signals   
   
   tf = 4.0;
   td = [0 : T : tf];
   nx = length(td);
   for i = 1 : nx
      y(i) = f_funx(td(i),xm,userinput);
   end
   [bin,di,yq] = f_adc(y,N,Vr);
   
   p = max(10*nx,100);	
   t = linspace(0,tf,p)';
   y_b = zeros(p,1);
   for i = 1 : p
      for k = 1 : nx-1
         if (t(i) >= td(k)) & (t(i) < td(k+1))
            y_b(i) = yq(k);
         end
      end
   end
   plot(t,y_b,'Color',colors(2,:),'LineWidth',1.0)
   hold on

   if n > 0
      X = [t y_b];
	  options = [];
  	  y0 = zeros(n,1);
	  [t,v] = ode45('f_butter',t,y0,options,b,a,0,userinput,X);
      y_a = v(:,1);
   else
      y_a = y_b;
   end
   plot(t,y_a,'b','LineWidth',1.5);
   stem (td,yq,'filled','r.')
   plot ([t(1) t(p)],[0 0],'k')
   f_labels (caption,'t (sec)','y(t)','',fsize)
   hl = legend ('y_b(t)','y_a(t)','y');
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   box on
   
elseif (pv == 2) 
   
% Plot spectra

   q = 512;
   fss = 4*fs;
   tf = (q-1)/fss;
   t = linspace(0,tf,q);
   freq = linspace(-fss/2,fss/2,q);
   for i = 1 : q
      y_c(i) = f_funx(t(i),xm,userinput);
   end
   Y_c = f_unscramble(abs(fft(y_c)));
   scale_1 = .5;
   Y = scale_1*Y_c;
   Y(1:q/2) = Y(1:q/2) + scale_1*Y_c(q/2+1:q);
   Y(q/2+1:q) = Y(q/2+1:q) + scale_1*Y_c(1:q/2);
   Y(1:q/2) = Y(1:q/2) + scale_1*Y_c(q/4+1:3*q/4);
   Y(q/2+1:q) = Y(q/2+1:q) + scale_1*Y_c(q/4+1:3*q/4);
   plot(freq,Y,'r')
   hold on
   
   % Multiply Y by mag response of DAC
   
   T = 1/fs;
   for i = 1 : q
      s = j*2*pi*freq(i);
      if (i == (q+1)/2)
         A(i) = T;
      else
         A(i) = abs((1 - exp(-s*T))/s);
      end
      Y_b(i) = (1/T)*A(i)*Y(i);
   end
   plot(freq,Y_b,'Color',colors(2,:))
   hl = legend ('|Y_b(f)|','|Y_a(f)|','|Y(f)|');
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   
   % Multiply by mag response of f_butter
     
   if n > 0
      A = 1./sqrt(1 + (freq/Fc).^(2*n));
   else
      A = ones(size(freq));
   end
   Y_a = A .* Y_b;
   plot (freq,Y_a,'b','LineWidth',1.5)
   scale_2 = 1.5;
   x_max = scale_2*max(Y);
   plot ([-fs/2 -fs/2 fs/2 fs/2],...
      [0 x_max x_max 0],'k:')
   f_labels (caption,'f (Hz)','|Y(f)|','',fsize)
   hl = legend ('|Y(f)|','|Y_b(f)|','|Y_a(f)|','Scaled ideal filter');
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   
elseif (pv == 3)
   
% Plot filter and DAC magnitude responses

   q = 256;	
   freq = linspace(-3*fs,3*fs,q);
   T = 1/fs;
   for i = 1 : q
      s = j*2*pi*freq(i);
      if (i == (q+1)/2)
         A_DAC(i) = T;
      else
         A_DAC(i) = abs((1 - exp(-s*T))/s);
      end
   end
   plot (freq,A_DAC/T,'Color',colors(2,:));
   hold on
   if n > 0
      A_f = 1./sqrt(1 + (freq/Fc).^(2*n));
   else
      A_f = ones(length(freq));
   end
   plot (freq,A_f,'LineWidth',1.5)
   caption = ['DAC and anti-imaging filter magnitude responses' s3];
   f_labels (caption,'f (Hz)','A(f)','',fsize)   
   hl = legend ('DAC','Anti-imaging filter');   
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   xlim = get(gca,'Xlim');
   axis ([xlim 0 1.2])
end   
