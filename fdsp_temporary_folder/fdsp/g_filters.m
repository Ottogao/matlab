% G_FILTERS: GUI module, filter specifications and structures
%
% Usage: g_filters
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate filter design 
%              specifictations and compare filter realization 
%              structures.  It can be used to demonstrate 
%              finite word length effects.
% Edit window:
%              F_0     = lower cutoff frequency
%              F_1     = upper cutoff frequency
%              B       = transition bandwidth
%              delta_p = passband ripple
%              delta_s = stopband attenuation
% Type window:
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
%              Quantizer characteristic
% Checkboxes:
%              IIR filter
%              dB display
% Slider bar:
%              Number of bits: N
% Menu bar:
%              Realization option
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SYSTEM 
%              G_SPECTRA G_CORRELATE G_FIR G_MULTIRATE 
%              G_IIR G_ADAPT

% Programming notes:

%1) No way to adjust FIR order?
%2) Use Settings menu to change IIR and FIR selections (e.g. FIR order?)

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 1;                    % plot view
fs = 2000;                 % sampling frequency
N = 12;                    % number of bits of fixed point precision
N_min = 2;                 % minimum number of bits
N_max = 64;                % maximum number of bits
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
iir = 1;                   % 0 = FIR, 1 = IIR
xm = 2;                    % filter type
xm_old = xm;               % previous xm 
realize = 0;               % filter realization (0=dirct,1=cascade)
n = 4;                     % filter order
a = [1 0 .8];              % denominator
b = [1 .6 -1];             % numerator
cq = 0;                    % coefficient quantization switch
white = [1 1 1];
M = 1000;
x = f_randu(M,1,-1,1);
y = filter(b,a,x);

% Strings                          
                          
userinput = 'u_filters1.mat';       % default MAT file containing user-defined x,y,fs
inputstr  = ['[b,a,n,fs,x,y,userinput,xm,xm_old] = '...
             'f_getfilters (hc_iir,xm,xm_old,fs,F_0,F_1,B,delta_p,delta_s,realize,b,a,x,y,userinput,hc_type); '];
plotstr   =  'f_plotfilters (pv,han,cq,N,fs,F_0,F_1,B,delta_p,delta_s,hc_dB,a,b,hc_iir,xm,realize,userinput,fsize); ';
barstr    = 'f_showslider (hc_N,han,N,''bits'',1); ';
g_module  = 'g_filters';
drawstr   = 'f_drawfilt (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

hm_realize = f_realizemenu (inputstr,plotstr,realize);
hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr)
f_helpmenu ('f_tipsfilt',g_module)
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

% Select filter type

nt = 5;
labels = {'Lowpass','Highpass','Bandpass','Bandstop','User-defined'};
ustr = ['if n==0, '...
        ' iir = 0; '...
        ' set(hc_iir,''Value'',0), '...
        'else '...
        ' iir = 1; '...
        ' set(hc_iir,''Value'',1),'...
        'end; '...
        'f_showslider (hc_N,han,N,''bits'',1); '];
fstr = ['if xm <= 4, '...
            barstr ...
        'else, ' ...
            ustr ...
        'end; '];
tipstrs = {'Lowpass filter','Highpass filter','Bandpass filter','Bandstop filter','Load a,b,fs'};
cback = {[inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr]};
 [hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt+1,fsize);

% Select view

nv = 5;
labels = {'Magnitude response','Phase response','Pole-zero plot','Impulse response','Quantizer characteristic'};
cback = {plotstr,plotstr,plotstr,plotstr,plotstr};
fcolors = {colors(2,:),colors(2,:),colors(2,:),colors(3,:),colors(1,:)};
tipstrs = {'Plot A(f)','Plot phi(f)','Sketch pole-zero pattern','Plot h(k)','Plot Q_N(x)'};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv+1,fsize);

% Check boxes

hc_iir = f_checkbox (iir,pos(3,:),nt+1,1,nt+1,1,'IIR filter',colors(2,:),...
                     white,[inputstr plotstr],'Toggle IIR/FIR display',fsize);

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

% Number of bits slider             

dv = 0;
tipstr = 'Adjust number of bits N';
cback = [barstr plotstr];
hc_N = f_slider (N,N_min,N_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'bits',fsize);

% Compute initial filter

eval (inputstr);

% Create plot

eval (plotstr)
