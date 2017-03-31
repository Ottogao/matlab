% G_SPECTRA: GUI module for analyis of signal spectra
%
% Usage: g_spectra
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate the spectra of 
%              discrete-time signals. This includes magnitude, 
%              phase, and power density spectra.  It also 
%              includes signal spectrograms.
% Edit window:
%              fs = sampling frequency
%              f0 = cosine frequency
%              c  = noise level
%              d  = clipping threshold
%              fs = sampling frequency
% Pushbuttons:
%              Play x as sound
% Checkboxes:
%              dB display
%              Additive noise [c,c]
%              Clip x to [-d,d]
% Type window:
%              White noise input
%              Cosine input
%              Damped exponential input
%              Record x 
%              User-defined input
% View window:
%              Time signal
%              Maginitude spectrum
%              Phase spectrum
%              Power density spectrum
%              Data window
%              Spectrogram
% Slider bar:
%              Number of samples: N
% Menu bar:
%              Window option
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option
%              Exit option
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SYSTEM 
%              G_CORRELATE G_FILTERS G_FIR G_MULTIRATE
%              G_IIR G_ADAPT

% Programming notes:

% 1) Put in a Settings menu option?

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 2;                   % plot view
fs = 2000;                % sampling frequency
T = 1/fs;                 % sampling interval 
fa = 200;                 % sinusoid frequency
c = 0.5;                  % bound of uniform white noise [-b,b]
d = 0.5;                  % clipping threshold 
clip = 0;                 % no clipping 
noise = 0;                % additive noise
N = 1024;                 % number of samples
L = N/4;                  % length of subsequence
xm = 2;                   % input signal selection
xm_old = xm;              % previous xm
win = 2;                  % data window
dB = 0;                   % linear plots (1 = log)
fs_min = 1;               % minimum sampling frequency
fs_max = 1.e6;            % maximum sampling frequency 
fa_min = 0;               % minimum cosine frequency
fa_max = fs_max/2;        % maximum cosine frequency 
c_max = 1000;             % maximum upper limit on white noise  
d_min = 0;                % minimum clipping threshold
N_min = 32;               % minimum number of samples
N_max = 8192;             % maximum number of samples
rand ('state',1000);      % seed random number generator
white = [1 1 1];
a = 1;
b = (1/10)*ones(1,10);
x = zeros(N,1);

% Strings                          
                          
userinput = 'u_spectra1.mat';       % default MAT file containing user-defined input
inputstr =  ['[x,y,N,fs,userinput,xm,xm_old] = '...
          'f_getspec (xm,xm_old,N,N_max,fs,fa,a,b,c,d,hc_noise,hc_clip,x,userinput,hc_type); '];
plotstr = 'f_plotspec (pv,han,hc_N,fs,win,hc_dB,hc_clip,hc_noise,x,xm,userinput,fsize); ';
barstr = 'f_showslider (hc_N,han,N,'''',1); ';
g_module = 'g_spectra';
drawstr = 'f_drawspec (han(1),colors,fsize)';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

hm_window = f_windowmenu (win,plotstr);
hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr) 
f_helpmenu ('f_tipsspec',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
cback =  [inputstr plotstr];
hc_fs = f_editbox (fs,fs_min,fs_max,pos(2,:),4,1,1,colors(1,:),white,cback,'Sampling frequency',fsize);
hc_fa = f_editbox (fa,fa_min,fa_max,pos(2,:),4,2,1,colors(1,:),white,cback,'Cosine frequency',fsize);
hc_c  = f_editbox (c,0,c_max,pos(2,:),4,3,1,colors(2,:),white,cback,'Additive noise level',fsize);
hc_d  = f_editbox (d,d_min,d,pos(2,:),4,4,1,colors(2,:),white,cback,'Clipping threshold',fsize);

% Check boxes

hc_dB    = f_checkbox (dB,pos(2,:),4,2,2,2,'dB display',colors(3,:),white,plotstr,'Toggle dB display',fsize);
hc_noise = f_checkbox (noise,pos(2,:),4,2,3,2,'Additive noise [-c,c]',colors(2,:),white,cback,...
                       'Toggle additive noise',fsize);
hc_clip  = f_checkbox (clip,pos(2,:),4,2,4,2,'Clip x to [-d,d]',colors(2,:),white,cback,...
                       'Toggle signal clipping',fsize);
 
% Push buttons

axes (han(2))
pushxstr = ['soundsc(x(1:N),fs); '...
            'tau = N/fs + .5; '...
            'tic; while toc < tau, end;'];
hc_pushx = f_pushbutton (pos(2,:),4,2,1,2,'Play x as sound',colors(1,:),white,pushxstr,'Play x on PC speaker',fsize);

% Select input type

nt = 5;
labels = {'White noise','Cosine','Damped exponential','Record x','User-defined'};
estr = ['set (hc_N,''Value'',N);'...
        'str_1 = [''c = '' mat2str(c) '';''];'...
        'set(hc_c,''String'',str_1);'...
        'str_1 = [''d = '' mat2str(d) '';''];'...
        'set(hc_d,''String'',str_1);'...
        'str_1 = [''fs = '' mat2str(fs) '';''];'...
        'set(hc_fs,''String'',str_1);'...
        'f_showslider (hc_N,han,N,'''',0);  '];
fstr = ['if xm <= 3, '...
            barstr ...
        'else, ' ...
            estr ...
        'end; '];
tipstrs = {'Uniform white noise','x(k) = cos(2*pi*fa*k*T)','x(k) = exp(-4*k/N)',...
           'Record 1.0 second of x(k)','Load x,fs'};
cback = {[inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr]};       
[hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt,fsize);

% Select view

nv = 6;
labels = {'Time signal','Magnitude spectrum','Phase spectrum','Power density spectrum','Window','Spectrogram'};
cback = {plotstr,plotstr,plotstr,plotstr,plotstr,plotstr};
fcolors = {colors(1,:),colors(3,:),colors(3,:),colors(3,:),colors(3,:),colors(3,:)};
tipstrs = {'Plot x(k)','Plot A(f)','Plot \phi(f)','Plot S_N(f)','Plot data window','Plot spectrogram'};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv,fsize);
 
% Number of samples slider             

dv = 2;
tipstr = 'Adjust number of samples';
cback = [inputstr barstr plotstr];
hc_N = f_slider (N,N_min,N_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'',fsize);

% Create plot

eval (inputstr)
eval (plotstr)
 