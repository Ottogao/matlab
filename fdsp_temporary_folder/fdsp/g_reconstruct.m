% G_RECONSTRUCT: GUI module for signal reconstruction
%
% Usage: g_reconstruct
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate the reconstruction
%              of analog signals from their samples.  The 
%              effects of the sampling rate, the anti-imaging 
%              filter, and the DAC characteristics can be 
%              examined.
% Edit window:
%              N  = DAC precision
%              Vr = DAC reference voltage
%              n  = anti-imaging filter order
%              Fc = anti-imaging filter cutoff frequency
% Type window:
%              Constant input
%              Damped exponential input
%              Cosine input
%              Square wave input
%              User-defined input
% View window:
%              Time signals
%              Maginitude spectra
%              Magnitude responses
% Slider bar:
%              Sampling frequency: fs
% Menu bar:
%              Caliper option
%              Print option
%              Help option
%              Exit option
% See also: 
%              F_DSP G_SAMPLE G_SYSTEM G_SPECTRA G_CORRELATE
%              G_FILTERS G_FIR G_MULTIRATE G_IIR G_ADAPT

% Programming notes:

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 1;                   % plot view
xm = 3;                   % input signal selection
xm_old = xm;              % previous xm
fs = 20;                  % sampling frequency
fs_min = 1;               % minimum sampling frequency
fs_max = 100;             % maximum sampling frequency
n = 4;                    % anti-aliasing filter order
n_min = 0;                % minimum anti-aliasing filter order
n_max = 16;               % maximum anti-aliasing fitler order
Fc = fs/4;                % anti-aliasing filter cutoff frequency
Fc_min = 1;               % minimum anti-aliasing filter cutoff frequency  
Fc_max = 20;              % maximum anti-aliasing filter cutoff frequency
N = 8;                    % ADC precision (bits)
N_min = 1;                % minimum ADC precision (bits)
N_max = 24;               % maximum ADC precision (bits)
Vr = 1.0;                 % ADC reference voltage
Vr_min = 0;               % minimum ADC reference voltage  
Vr_max = 100;             % maximum ADC reference voltage
white = [1 1 1];

% Strings

userinput = 'u_reconstruct1';  % name of user-supplied input function
plotstr = 'f_plotrec(pv,han(6),hc_fs,xm,n,Fc,N,Vr,userinput,fsize); ';
barstr = 'f_showslider (hc_fs,han,fs,''Hz'',1); ';
inputstr = '';
g_module = 'g_reconstruct';
drawstr = 'f_drawrecon (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

f_calmenu (plotstr)
f_printmenu (han,drawstr)
f_helpmenu ('f_tipsrec',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
hc_N = f_editbox (N,N_min,N_max,pos(2,:),2,1,1,colors(2,:),white,plotstr,'Number of bits',fsize);
hc_Vr = f_editbox (Vr,Vr_min,Vr_max,pos(2,:),2,2,1,colors(2,:),white,plotstr,'Reference voltage',fsize);
hc_n = f_editbox (n,n_min,n_max,pos(2,:),2,1,2,colors(1,:),white,plotstr,'Filter order',fsize);
hc_Fc = f_editbox (Fc,Fc_min,Fc_max,pos(2,:),2,2,2,colors(1,:),white,plotstr,'Filter cutoff frequency',fsize);
 
% Select input type

nt = 5;
msg = {'The M-file function u_fir1 is a function of (f,fs).  The user-defined',...
       'M-file function for g_reconstruct must be a function of t. See files',... 
       'u_sample1.m and u_reconstruct1.m for examples.'};
labels = {'Constant','Damped exponential','Cosine','Square wave','User-defined'};
ustr = ['user = f_getfun (userinput,''Select user input function''); '...
        'if isequal(user,0), '...
        '   set (hc_type(xm),''Value'',0), '...
        '   set (hc_type(xm_old),''Value'',1), '...
        '   xm = xm_old; '...
        'else, '...
        '   userinput = user; '...
        '   xm_old = xm; '...
        'end; '...
        'user1 = lower(user); '...
        'if strcmp(user1,''u_fir1.m'') | strcmp(user1,''u_fir1''), '... 
        '   button = questdlg (msg,''User-defined M-file function warning'',''Ok'',''Ok''); '...   
        '   userinput = ''u_reconstruct1''; '...    
        'end; '];
xstr = 'xm_old = xm; ';
tipstrs = {'y(k) = 1','y(k) = exp(-k*T)','y(k) = cos(2*pi*k*T)',...
           'y(k) = sgn(sin(2*pi*k*T))','Compute y(k) using user-supplied function'};
cback = {[xstr plotstr],...
         [xstr plotstr],...
         [xstr plotstr],...
         [xstr plotstr],...
         [ustr plotstr]};
[hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt,fsize);

% Select view

nv = 3;
labels = {'Time signals','Magnitude spectra','Magnitude responses'};
fcolors = {colors(1,:),colors(1,:),colors(2,:)};
tipstrs = {'Plot y(k),y_b(t),y_a(t))','Plot |Y(f)|,|Y_b(f)|,|Y_a(f)|','Plot |H_0(f)|,|H_a(f)|'};
cback ={plotstr,plotstr,plotstr};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv,fsize);

% Sampling frequency slider             

dv = 0;
tipstr = 'Adjust sampling frequency';
cback = [barstr plotstr];
hc_fs = f_slider (fs,fs_min,fs_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'Hz',fsize);

% Create plot

eval (plotstr)
 