% G_IIR: GUI module for IIR filter design
%
% Usage: g_iir
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate the design of IIR 
%              digital filters. The design methods are based 
%              on bilinear transformations of the classical 
%              analog filters (Butterworth, Chebyshev-I,
%              Chebyshev-II, and elliptic).The frequency-
%              selective filter types include lowpass, 
%              highpass, bandpass, and bandstop filters.
% Edit window:
%              F_0     = lower cutoff frequency
%              F_1     = upper cutoff frequency
%              B       = transition bandwidth
%              delta_p = passband ripple
%              delta_s = stopband attenuation
% Type window:
%              Resonator filter
%              Notch filter
%              Lowpass filter
%              Highpass filter
%              Bandpass filter
%              Bandstop filter 
%              User-defined filter
% View window:
%              Magnitude response
%              Phase response
%              Pole-zero plot
%              Impulse response
%              Window
% Checkboxes:
%              dB display
% Slider bar:
%              IIR filter order: m
% Menu bar:
%              Prototype option
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option 
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SYSTEM 
%              G_SPECTRA G_CORRELATE G_FILTERS G_FIR 
%              G_MULTIRATE G_ADAPT

% Programming notes:

%1) Have n_max depend or filter type? 

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 1;                    % plot view
fs = 2000;                 % sampling frequency
n = 8;                     % IIR filter order
n_min = 1;                 % minimum filter order
n_max = 24;                % maximum filter order
dB = 0;                    % linear plots (1 = log)
fs_min = 1;                % minimum sampling frequency
fs_max = 1.e6;             % maximum sampling frequency 
F_0 = .2*fs;               % lower cutoff frequency
F_1 = .3*fs;               % upper cutoff frequency
B = 100;                   % transition bandwidth
delta_p = 0.1;             % passband ripple (linear)
delta_s = 0.1;             % stopband ripple (linear)
A_p =-20*log10(1-delta_p); % passband ripple (dB)
A_s =-20*log10(delta_s);   % stopband ripple (dB)
xm = 5;                    % fitler type
xm_old = xm;               % previous xm
proto = 2;                 % analog prototype filter
order = 1;                 % filter order switch (0 = automatic,1 = adjustable)
a = [1 0 .8];              % denominator
b = [1 .6 -1];             % numerator
cq = 0;                    % coefficient quantization switch
white = [1 1 1];
M = 1000;
x = f_randu(M,1,-1,1);
y = filter(b,a,M);

% Strings                          
                          
userinput  = 'u_iir1.mat';       % default MAT file for saving a,b,fs 
inputstr   = ['[b,a,n,fs,x,y,userinput,xm,xm_old] = '...
              'f_getiir (xm,xm_old,fs,F_0,F_1,B,delta_p,delta_s,proto,b,a,x,y,userinput,n,hc_type); '];
plotstr    = 'f_plotiir (pv,han,fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,xm,proto,n,userinput,fsize); ';
barstr     = 'f_showslider (hc_n,han,n,'''',1); ';
g_module = 'g_iir';
drawstr  = 'f_drawfilt (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

hm_iir = f_iirmenu (inputstr,plotstr,proto);
hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr)
f_helpmenu ('f_tipsiir',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
cback =  [inputstr plotstr];
hc_F0 = f_editbox (F_0,0,fs/2,pos(2,:),3,1,1,colors(2,:),white,cback,'Lower cutoff frequency',fsize);
hc_F1 = f_editbox (F_1,F_0,fs/2,pos(2,:),3,2,1,colors(2,:),white,cback,'Upper cutoff frequency',fsize);
hc_B  = f_editbox (B,0,B,pos(2,:),3,3,1,colors(2,:),white,cback,'Transition bandwidth',fsize);
hc_fs = f_editbox (fs,fs_min,fs_max,pos(2,:),3,1,2,colors(1,:),white,cback,'Sampling frequency',fsize);

cback5b = ['if dB == 0, '...
           ' eval(get(hc_delta_p,''String'')),delta_p = f_clip(delta_p,0,1);'...
           ' A_p = -20*log10(1 - delta_p);'...
           'else, '...
           ' eval(get(hc_delta_p,''String'')),A_p = f_clip(A_p,0,A_p);'...
           ' delta_p = 1 - 10^(-A_p/20);'...
           'end; '];
hc_delta_p = f_editbox (delta_p,0,1,pos(2,:),3,2,2,colors(2,:),...
                        white,[cback5b inputstr plotstr],'Passband ripple',fsize);

cback6b = ['if dB == 0, '...
           ' eval(get(hc_delta_s,''String'')),delta_s = f_clip(delta_s,0,1);'...
           ' A_s = -20*log10(delta_s);'...
           'else, '...
           ' eval(get(hc_delta_s,''String'')),A_s = f_clip(A_s,0,A_s);'...
           ' delta_s = 10^(-A_s/20);'...
           'end; '];
hc_delta_s = f_editbox (delta_s,0,1,pos(2,:),3,3,2,colors(2,:),...
                        white,[cback6b inputstr plotstr],'Stopband attenuation',fsize);

% Filter order slider

dv = 0;
step1a = 1 /(n_max - n_min);
step1b = 2 /(n_max - n_min);
step2 = 0.1*n_max/(n_max-n_min);
oddstr  = 'set(hc_n,''SliderStep'',[step1a,step2]), ';
evenstr = 'set(hc_n,''SliderStep'',[step1b,step2]), ';
tipstr = 'Adjust IIR filter order n';
cback = [inputstr barstr plotstr];
hc_n = f_slider (n,n_min,n_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'',fsize);
                      
% Select filter type

nt = 7;
labels = {'Resonator','Notch','Lowpass','Highpass','Bandpass','Bandstop','User-defined'};
estr = 'f_showslider (hc_n,han,n,'''',0); ';
fstr = ['if (xm <= 2), '...
            [estr oddstr] ...
        'elseif (xm >= 3) & (xm <= 4), ' ...
            [barstr oddstr] ...
        'elseif (xm == 7), '...
            [estr oddstr] ...
            'str_1 = [''fs = '' mat2str(fs) '';''];'...
            'set(hc_fs,''String'',str_1);'...
        'else, '...
            'n = 2*floor(n/2); ' ... 
            [barstr evenstr] ...
        'end; '];
tipstrs = {'Resonator filter','Notch filter','Lowpass filter','Highpass filter',...
           'Bandpass filter','Bandstop filter','Load a,b,fs'};
cback = {[inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr]};
 [hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt,fsize);
                    
% Select view

nv = 4;
labels = {'Magnitude response','Phase response','Pole-zero plot','Impulse response'};
cback = {plotstr,plotstr,plotstr,plotstr};
fcolors = {colors(2,:),colors(2,:),colors(2,:),colors(2,:)};
tipstrs = {'Plot A(f)','Plot phi(f)','Sketch poles and zeros','Plot h(k)'};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv+1,fsize);

% Check boxes

cbackdB = ['dB = get (hc_dB,''Value''); '...
           'if dB,'...  
           ' set(hc_dB,''Value'',1),'...
           ' eval(get(hc_delta_p,''String'')),'...
           ' eval(get(hc_delta_s,''String'')),'...
           ' A_p = -20*log10(1 - delta_p);'...
           ' A_s = -20*log10(delta_s);'...
           ' set(hc_delta_p,''String'',[''A_p = '',mat2str(A_p,3),'';'']),'...
           ' set(hc_delta_s,''String'',[''A_s = '',mat2str(A_s,3),'';'']),'...
           'else,'...
           ' set(hc_dB,''Value'',0),'...
           ' eval(get(hc_delta_p,''String'')),'...
           ' eval(get(hc_delta_s,''String'')),'...
           ' set(hc_dB,''Value'',0),'...
           ' delta_p = 1 - 10^(-A_p/20);'...
           ' delta_s = 10^(-A_s/20);'...
           ' set(hc_delta_p,''String'',[''delta_p = '',mat2str(delta_p,3),'';'']),'...
           ' set(hc_delta_s,''String'',[''delta_s = '',mat2str(delta_s,3),'';'']),'...
           'end; '];
hc_dB = f_checkbox (dB,pos(4,:),nv+1,1,nv+1,1,'dB display',colors(3,:),...
                     white,[cbackdB inputstr plotstr],'Toggle dB display',fsize);
                    

% Compute initial filter

eval (inputstr);

% Create plot

eval (plotstr)
 