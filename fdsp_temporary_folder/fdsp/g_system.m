% G_SYSTEM: GUI module for analysis of discrete-time systems
%
% Usage: g_system
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate the solution of 
%              discrete-time systems. In addition to time 
%              plots for various inputs, there are pole-zero 
%              plots and impulse response plots.
% Edit window:
%              a  = denominator coefficient vector
%              b  = numerator coefficient vector
%              c  = cosine damping factor
%              f0 = cosine frequency
%              fs = sampling frequency
% Pushbuttons:
%              Play x as sound
%              Play y as sound
% Type window:
%              White noise input
%              Unit impulse input
%              Unit step input
%              Damped cosine input
%              Record x 
%              User-defined input
% View window:
%              Time signals
%              Maginitude response
%              Phase response
%              Pole-zero plot
% Checkboxes:
%              Stem plot
%              dB display
% Slider bar:
%              Number of samples: N
% Menu bar:
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option
%              Exit option
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SPECTRA 
%              G_CORRELATE G_FILTERS G_FIR G_MULTIRATE 
%              G_IIR G_ADAPT

% Programming notes:

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 4;                   % plot view
stem_plot = 0;            % use stem plots for input and output
xm = 4;                   % input signal selection
xm_old = xm;              % last selection
dB = 0;                   % linear plots (1 = log)
fs = 2000;                % sampling frequency
fs_min = 1;               % minimum sampling frequency
fs_max = 1.e6;            % maximum sampling frequency 
T = 1/fs;                 % sampling interval 
N = 300;                  % number of samples
N_min = 8;                % minimum number of samples
N_max = 8192;             % maximum number of samples
rand ('state',1000);      % seed random number generator
a = [1 0 .8];             % denominator
b = [1 .6 -1];            % numerator
f0 = 0.15*fs;             % damped cosine frequency 
c = 0.99;                 % input damping
white = [1 1 1];
x = zeros(N,1);

% Strings                          
                          
userinput = 'u_system1.mat';       % default MAT file containing user-defined input
plotstr = 'y = f_plotsys (pv,han,xm,N,fs,hc_dB,a,b,x,c,f0,userinput,hc_stem,fsize); ';
inputstr ='[x,N,fs,a,b,userinput,xm,xm_old] = f_getsys (xm,xm_old,N,N_max,fs,f0,a,b,c,x,userinput,hc_type); ';
barstr = 'f_showslider (hc_N,han,N,'''',1); ';
g_module = 'g_system';
drawstr = 'f_drawsys (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr)
f_helpmenu ('f_tipssys',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
cback =  [inputstr plotstr];
hc_a  = f_editbox (a,-inf,inf,pos(2,:),4,1,1,colors(2,:),white,plotstr,'Denominator coefficients',fsize);
hc_b  = f_editbox (b,-inf,inf,pos(2,:),4,2,1,colors(2,:),white,plotstr,'Numerator coefficinets',fsize);
hc_c  = f_editbox (c,0,1,pos(2,:),4,3,1,colors(1,:),white,cback,'Input damping factor',fsize);
hc_f0 = f_editbox (f0,0,0.5*fs,pos(2,:),4,4,1,colors(1,:),white,cback,'Input frequency',fsize);
hc_fs = f_editbox (fs,fs_min,fs_max,pos(2,:),3,1,2,colors(1,:),white,cback,'Sampling frequency',fsize);

% Select input type

nt = 6;
labels = {'White noise','Unit impulse','Unit Step','Damped cosine','Record x','User-defined'};
estr = ['str_b = [''b = '' mat2str(b) '';''];'...
        'set(hc_b,''String'',str_b);'... 
        'str_a = [''a = '' mat2str(a) '';''];'...
        'set(hc_a,''String'',str_a);'... 
        'str_fs = [''fs = '' mat2str(fs) '';''];'...
        'set(hc_fs,''String'',str_fs);'...
        'f_showslider (hc_N,han,N,'''',0); '];
fstr = ['if xm <= 4, '...
            barstr ...
        'else, ' ...
            estr ...
        'end; '];
tipstrs = {'x(k) = v(k)','x(k) = delta(k)','x(k) = u(k)','x(k) = c^k*cos(2*pi*f0*k*T)',...
           'Record one second of x(k)','Load a,b,x,fs'};

cback = {[inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr],...
         [inputstr fstr plotstr]};       

[hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt,fsize);

% Select view

nv = 4;
labels = {'Time signals','Magnitude response','Phase response','Pole-zero plot'};
cback = {plotstr,plotstr,plotstr,plotstr};
fcolors = {colors(1,:),colors(2,:),colors(2,:),colors(2,:)};
tipstrs = {'Plot x(k) and y(k)','Plot |H(f)|','Plot phi(f)','Sketch poles,zeros and Plot |H(z)|'};
[hc_view,dw,dz] = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv+2,fsize);

% Check boxes

hc_stem = f_checkbox (stem_plot,pos(4,:),nv+2,1,nv+1,1,'Stem plot',colors(3,:),white,plotstr,'Toggle stem plot display',fsize);
hc_dB = f_checkbox (dB,pos(4,:),nv+2,1,nv+2,1,'dB display',colors(3,:),white,plotstr,'Toggle dB display',fsize);

% Push buttons

eval(plotstr)
axes (han(2))
pushxstr = ['soundsc(x(1:N),fs); '...
            'tau = N/fs + .5; '...
            'tic; while toc < tau, end;'];
pushystr = ['soundsc(y(1:N),fs); '...
            'tau = N/fs + .5; '...
            'tic; while toc < tau, end;'];
hc_pushx = f_pushbutton (pos(2,:),3,2,2,2,'Play x as sound',colors(1,:),white,pushxstr,'Play x on PC speaker',fsize);
hc_pushy = f_pushbutton (pos(2,:),3,2,3,2,'Play y as sound',colors(3,:),white,pushystr,'Play y on PC speaker',fsize);

% Number of samples slider             

dv = 0;
tipstr = 'Adjust Number of Samples';
cback = [inputstr barstr plotstr];
hc_N = f_slider (N,N_min,N_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'',fsize);

% Create plot

eval (inputstr)
eval (plotstr)
 