function [w,y] = f_plotadapt (pv,han,x,d,a,b,m,mu,nu,alpha,beta,gamma,hc_dB,fs,method,hc_data,user,fsize)

%F_PLOTADAPT: Plot the selected view for the GUI module G_ADAPT
%
% Usage: [w,y] = f_plotadapt (pv,han,x,d,a,b,m,mu,nu,alpha,beta,gamma,hc_dB,fs,method,hc_data,user,fsize)
%
% Inputs: 
%         pv      = view selector
%         han     = array of axes handles 
%         x       = N by 1 vector of input samples 
%         d       = N by 1 vector of desired output samples
%         a       = n by 1 vector of denominator coefficients of black box
%         b       = (M+1) by 1 vector of numerator coefficients of black box
%         m       = order of adaptive filter (0 to 100)
%         mu      = step size (0 to 1/((m+1)*P_x))   
%         nu      = leakage factor
%         alpha   = normalized step size (0 to 1)
%         beta    = smoothing factor
%         gamma   = forgetting factor
%         hc_dB   = handle of dB display checkbox
%         fs      = sampling frequency in Hz
%         method  = adaptive filter design method (1 to 5)
%         hc_data = handle of data source checkbox
%         user    = string containing name of MAT file with d and x
%         fsize   = font size          
% Outputs: 
%         w = (m+1) by 1 weight vector
%         y = N by 1 vector of filter output samples

% Initialize

dB = get (hc_dB,'Value');
data_source = get (hc_data,'Value');
colors = get(gca,'ColorOrder');
N = length(x);
k = 0 : N-1;
p = 250;
f_ploterase (han)
y = filter(b,a,x);

% Identify system using selected method

switch method
   
case 1, 

   caption = sprintf ('LMS method');
   [w,e] = f_lms (x,d,m,mu);
   
case 2,
    
    caption = sprintf('Normalized LMS method');
    [w,e,steps] = f_normlms (x,d,m,alpha);
    
case 3,
    
    caption = sprintf('Correlation LMS method');
    [w,e,steps] = f_corrlms (x,d,m,alpha,beta);
    
case 4,
    
    caption = sprintf('Leaky LMS method');
    [w,e] = f_leaklms (x,d,m,mu,nu);
    
  
case 5,
    
    caption = sprintf('RLS method');
    [w,e] = f_rls (x,d,m,gamma);

end

if data_source
    user1 = f_cleanstring (user);
    caption = sprintf ('Data from file %s, %s',user1,caption);
end

% Compute steady-state error

i = floor(N/2)+1: N;
E = sum(e(i).^2)/sum(d(i).^2);
s = sprintf (': m = %d, E = %.6f',m,E);
if (pv == 2) | (pv == 4)
    switch method
        case 1, s = sprintf (': m = %d, mu = %.4f, E = %.6f',m,mu,E);
        case 2, s = sprintf (': m = %d, alpha = %.3f, E = %.6f',m,alpha,E);
        case 3, s = sprintf (': m = %d, alpha = %.3f, beta = %.3f, E = %.6f',m,alpha,beta,E);
        case 4, s = sprintf (': m = %d, mu = %.4f, nu = %.3f, E = %.6f',m,mu,nu,E);
        case 5, s = sprintf (': m = %d, gamma = %.3f, E = %.6f',m,gamma,E);
    end
end

% Plot results

switch pv
   
case 1,                                               % input x  
   
   axes (han(6))
   axis on
   plot (k,x,'Color',colors(1,:))
   caption = [caption ', input ' s];
   f_labels (caption,'k','x(k)','',fsize)

case 2,                                               % outputs d and y  
   
   axes (han(6))
   axis on
   y = d - e;
   r = 1 : min(250,N);
   plot (r-1,d(r),'Color',colors(2,:),'LineWidth',1.5)
   hold on
   plot (r-1,y(r),'Color',colors(3,:))
   caption = [caption ', outputs ' s];
   f_labels (caption,'k','Outputs','',fsize)
   hl = legend ('d(k)','y(k)');
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   hold off
   
case 3,                                               % magnitude responses 
   
    
   axes (han(6))
   axis on
   if ~data_source
       [H_s,f1] = f_freqz (b,a,p,fs);
   else
        H_s = fft(d) ./ fft(x);
        N2 = floor(N/2);
        H_s(N2+1:N) = [];
        f1 = linspace (0,(N-1)*fs/N,N)';
        f1(N2+1:N) = [];
   end
   [H_m,f] = f_freqz (w,1,p,fs);
   if dB
      A_s = 20*log10(abs(H_s));
      A_m = 20*log10(abs(H_m));
   else
      A_s = abs(H_s);
      A_m = abs(H_m);
   end
   plot (f1,A_s,'Color',colors(2,:),'LineWidth',1.5)
   hold on
   plot (f,A_m,'Color',colors(3,:))
   caption = [caption ', magnitude responses ' s];
   if dB
      f_labels (caption,'f (Hz)','A(f) (dB)','',fsize)
   else   
      f_labels (caption,'f (Hz)','A(f)','',fsize)
   end
   hl = legend ('Black box','Adaptive filter');
   set (hl,'FontName','FixedWidthFontName','FontSize',fsize)
   hold off
   
case 4,                                               % learning curve
   
   axes (han(6))
   axis on
   hp = stem (k,e.^2,'filled','.');
   set (hp,'Color',colors(1,:))
   caption = [caption ', learning curve ' s];
   f_labels (caption,'k','e^2(k)','',fsize)
   
case 5,                                               % step sizes
   
   axes (han(6))
   axis on
   constant_mu = (method < 2) | (method > 3);
   if constant_mu
       steps(1:N) = mu;
   end
   plot (k,steps,'Color',colors(3,:));
   caption = [caption ', step sizes ' s];
   f_labels (caption,'k','\mu(k)','',fsize)
   if constant_mu
       axis ([0 N 0 2*steps(1)])
   end
   
case 6,                                                % final weights
 
   axes (han(6))
   axis on
   caption = [caption ', final weights ' s];
   hp = stem ([0:m],w,'filled','.');
   set (hp,'Color',colors(3,:))
   f_labels (caption,'i','w_i','',fsize)

end
