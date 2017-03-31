% G_MULTIRATE: GUI module for multirate signal processing
%
% Usage: g_multirate
%
% Version: 1.0
%
% Description: This graphical user interface module is used
%              to interactively investigate multirate signal 
%              processing technques.  The methods covered 
%              include integer sampling rate decimators, 
%              integer sampling rate interpolators, and 
%              rational sampling rate converters.
% Edit window:
%              fs = sampling frequency
%              L  = interpolation factor
%              M  = decimation factor
%              c  = cosine damping factor
% Pushbuttons:
%              Play x as sound
%              Play y as sound
% Type window:
%              White noise input
%              Damped cosine input
%              Amplitude-modulated input
%              Frequency-modulated input
%              Record x 
%              User-defined input
% View window:
%              Time signals
%              Magnitude spectra
%              Magnitude response
%              Phase response
%              Impulse response
% Checkboxes:
%              dB display
% Slider bar:
%              FIR filter order: m
% Menu bar:
%              FIR filter type
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SYSTEM 
%              G_SPECTRA G_CORRELATE G_FILTERS G_FIR 
%              G_IIR G_ADAPT

% Programming notes:

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 1;                    % plot view
fs = 4000;                 % sampling frequency
L = 3;                     % interpolation factor
M = 2;                     % decimation factor
L_max = 100;               % maximum interpolation factor
M_max = 100;               % maximum decimation factor
c = 0.99;                  % damping factor
xm = 4;                    % input type
xm_old = xm;               % previous xm
f_type = 5;                % fitler type
m = 60;                    % filter order
m_min = 2;                 % minimum filter order
m_max = 256;               % maximum filter order
dB = 0;                    % linear plots (1 = log)
fs_min = 1;                % minimum sampling frequency
fs_max = 44100;            % maximum sampling frequency 
white = [1 1 1];
a = 1;

% Strings                          
                          
userinput = 'u_multirate1.mat';       % default MAT file containing user-defined x,y,fs
inputstr  = '[x,y,b,fs,userinput,xm,xm_old] = f_getrate (xm,xm_old,fs,L,M,c,m,f_type,userinput,x,y,hc_type); ';
plotstr   = 'f_plotrate (pv,han,fs,hc_dB,L,M,m,c,x,y,b,xm,f_type,userinput,fsize); ';
barstr    = 'f_showslider (hc_m,han,m,'''',1); ';
g_module = 'g_multirate';
drawstr  = 'f_drawrate (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);

% Add menu options

hm_fir = f_firmenu (inputstr,plotstr,f_type,'Filter');
hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr) 
f_helpmenu ('f_tipsrate',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
cback =  [inputstr plotstr];
hc_fs = f_editbox (fs,fs_min,fs_max,pos(2,:),3,1,1,colors(1,:),white,cback,'Sampling frequency',fsize);
hc_L  = f_editbox (L,1,L_max,pos(2,:),3,2,1,colors(1,:),white,cback,'Intepolation factor',fsize);
hc_M  = f_editbox (M,1,M_max,pos(2,:),3,3,1,colors(3,:),white,cback,'Decimation factor',fsize);
hc_c  = f_editbox (c,-1,1,pos(2,:),3,1,2,colors(1,:),white,cback,'Damping parameter',fsize);

% Push buttons

axes (han(2))
pushxstr = ['soundsc(x,fs);'...
           'tau = length(x)/fs + .1;'...
           'tic; while toc < tau, end;'];
hc_pushx = f_pushbutton (pos(2,:),3,2,2,2,'Play x as sound',colors(1,:),white,pushxstr,'Play x on PC speaker',fsize);
pushystr = ['choice = questdlg(''Choose sampling rate for playing y'',''Playback Rate'','...
            '''Original rate'',''New rate'',''Original rate''); '...
            'if strcmp (choice,''Original rate''), '...
            '   Fs = fs; '...
            'else, '...
            '   Fs = floor((L/M)*fs); '...
            'end; '...
            'soundsc(y,Fs);'...
            'tau = length(y)/Fs + .1;'...
            'tic; while toc < tau, end;'];
hc_pushy = f_pushbutton (pos(2,:),3,2,3,2,'Play y as sound',colors(3,:),white,pushystr,'Play y on PC speaker',fsize);

% Select input type

nt = 6;
labels = {'White noise','Damped cosine','AM input','FM input','Record x','User-defined'};
estr = 'set(hc_fs,''String'',[''fs = '',mat2str(fs),'';'']); ';
tipstrs = {'White noise input','x(k) = c^kcos(2*pi*k*T)','Amplitude-modulated (AM) input',...
           'Frequency-modulated (FM) input','Record 1 second of x(k)','Load x,fs'};
cback = {[inputstr estr barstr plotstr],...
         [inputstr estr barstr plotstr],...
         [inputstr estr barstr plotstr],...
         [inputstr estr barstr plotstr],...
         [inputstr estr barstr plotstr],...
         [inputstr estr barstr plotstr]};       
[hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt,fsize);

% Select view

nv = 5;
labels = {'Time signals','Magnitude spectra','Magnitude response','Phase response','Impulse response'};
cback = {plotstr,plotstr,plotstr,plotstr,plotstr};
fcolors = {colors(1,:),colors(1,:),colors(2,:),colors(2,:),colors(2,:)};
tipstrs = {'Plot x(k) and y(k)','Plot |X(f)| and |Y(f)|','Plot A(f)',...
           'Plot phi(f)','Plot h(k)'};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv+1,fsize);

% Check boxes

hc_dB    = f_checkbox (dB,pos(4,:),nv+1,1,nv+1,1,'dB display',colors(3,:),white,plotstr,'Toggle dB display',fsize);

% Filter order slider

dv = 1;
tipstr = 'Adjust filter order m';
cback = [barstr plotstr];
hc_m = f_slider (m,m_min,m_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'',fsize);

% Create plot

x = zeros(1,1);
y = zeros(1,1);
eval(inputstr)
eval (plotstr)
