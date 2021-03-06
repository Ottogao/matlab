% G_ADAPT: GUI module for adaptive signal processing
%
% Usage: g_adapt
%
% Version: 1.0
%
% Description: 
%              This graphical user interface module is used
%              to interactively investigate system 
%              identification. The methods include: Least 
%              mean square (LMS) method, normalized LMS 
%              method, correlation LMS method, leaky LMS 
%              method, and the recursive least squares (RLS)
%              method.
% Edit window:
%              a     = denominator coefficient vector
%              b     = numerator coefficient vector
%              mu    = step size
%              alpha = normalized step size
%              fs    = sampling frequency
%              N     = number of samples 
%              nu    = leakage factor
%              beta  = smoothing factor
% Type window:
%              LMS method
%              Normalized LMS method
%              Correlation LMS method
%              Leaky LMS method
%              RLS method
% Checkboxes:
%              Data source
%              dB display
% View window:
%              Input 
%              Outputs 
%              Magnitude responses
%              Learning curve
%              Step sizes
%              Final weights
% Slider bar:
%              Transversal filter order: m
% Menu bar:
%              Save option: x,y,a,b,fs 
%              Caliper option
%              Print option
%              Help option 
% See also: 
%              F_DSP G_SAMPLE G_RECONSTRUCT G_SYSTEM 
%              G_SPECTRA G_CORRELATE G_FILTERS G_FIR 
%              G_MULTIRATE G_IIR

% Notes:

% Check MATLAB Version

if (f_oldmat)
   return
end

% Initialize

clc
clear all
pv = 4;                   % plot view
xm = 1;                   % adaptive filter algorithm
a = [1 0 0.85];           % denominator
b = [1 0 -1];             % numerator
m = 40;                   % filter order
m_min = 1;                % minimum filter order
m_max = 100;              % maximum filter order
mu = 0.02;                % step size
nu = 0.998;               % leakage factor
alpha = 0.2;              % normalized step length 
beta = 0.98;              % smoothing parameter
gamma = 0.95;             % forgetting factor
N = 500;                  % number of samples of input
N_min = 1;                % minimum number of samples
N_max = 8192;             % maximum number of samples
dB = 0;                   % linear plots (1 = log)
fs = 2000;                % sampling frequency
fs_min = 1;               % minimum sampling frequency
fs_max = 44100;           % maximum sampling frequency 
user = 'u_adapt1';        % default MAT file for user-defined data 
data_source = 0;          % data source (0 = computed, 1 = file)
x = zeros(N,1);           % vector of inputs samples
d = zeros(N,1);           % vector of desired output samples
white = [1 1 1];

% Strings                          
                          
userinput = 'u_adapt1.mat';       % default MAT file containing x,y,fs with y = d
inputstr  = '[x,d,N,fs,userinput] = f_getadapt (hc_data,x,d,a,b,N,fs,userinput); ';
plotstr   = '[w,y] = f_plotadapt (pv,han,x,d,a,b,m,mu,nu,alpha,beta,gamma,hc_dB,fs,xm,hc_data,userinput,fsize); ';
barstr    = 'f_showslider (hc_m,han,m,'''',1); ';
g_module  = 'g_adapt';
drawstr   = 'f_drawadapt (han(1),colors,fsize); ';

% Create figure window with tiled axes
 
[hf_1,han,pos,colors,fsize] = f_guifigure (g_module);
fsize;

% Add menu options

hm_save = f_savemenu (userinput,'','Save data');
f_calmenu (plotstr)
f_printmenu (han,drawstr)
f_helpmenu ('f_tipsadapt',g_module)
f_exitmenu

% Draw block diagram

eval(drawstr)

% Edit boxes

axes (han(2))
cback =  [inputstr plotstr];
x = f_randu(N,1,-1,1);
mu_max = length(x)/((m+1)*sum(x.^2));
hc_a     = f_editbox (a,-inf,inf,pos(2,:),4,1,1,colors(2,:),white,cback,'Denominator coefficient vector',fsize);
hc_b     = f_editbox (b,-inf,inf,pos(2,:),4,2,1,colors(2,:),white,cback,'Numerator coefficient vector',fsize);
hc_mu    = f_editbox (mu,0,mu_max,pos(2,:),4,3,1,colors(3,:),white,cback,'Step size',fsize);
hc_alpha = f_editbox (alpha,0,1,pos(2,:),4,4,1,colors(3,:),white,cback,'Normalized step size',fsize);
hc_fs    = f_editbox (fs,fs_min,fs_max,pos(2,:),4,1,2,colors(1,:),white,cback,'Sampling frequency',fsize);
hc_N     = f_editbox (N,N_min,N_max,pos(2,:),4,2,2,colors(1,:),white,cback,'Number of samples',fsize);
hc_nu    = f_editbox (nu,0,1,pos(2,:),4,3,2,colors(3,:),white,cback,'Leakage factor',fsize);
hc_beta  = f_editbox (beta,0,1,pos(2,:),4,4,2,colors(3,:),white,cback,'Smoothing factor',fsize);

% Select algorithm type

nt = 5;
labels = {'LMS method','Normalized LMS','Correlation LMS','Leaky LMS','RLS method'};
cback = {plotstr,...
         plotstr,...
         plotstr,...
         plotstr,...
         plotstr};
tipstrs = {'LMS method (mu)','Normalized LMS mehtod (alpha)','Correlation LMS method (alpha,beta)',...
           'Leaky LMS method (mu,nu)','RLS method (alpha, beta)'};
[hc_type,userinput] = f_typebuttons (pos(3,:),nt,xm,labels,colors(1,:),white,cback,userinput,tipstrs,nt+1,fsize);

% Select view

nv = 6;
labels = {'Input','Outputs','Magnitude responses','Learning Curve','Step sizes','Final weights'};
cback = {plotstr, plotstr, plotstr, plotstr, plotstr, plotstr};
fcolors = {colors(1,:),colors(2,:),colors(2,:),colors(1,:),colors(3,:),colors(3,:)};
tipstrs = {'Plot x(k)','Plot d(k) and y(k)','Plot A_d(f) and A_y(f)','Plot w^2(k)','Plot mu(k)','Plot final weights'};
hc_view = f_viewbuttons (pos(4,:),nv,pv,labels,fcolors,white,cback,tipstrs,nv+1,fsize);

% Check boxes

cbackdata = ['data_source = 1 - data_source; '...
             inputstr, ...
             'set(hc_N,''String'',[''N = '' mat2str(N)]), '...
             'set(hc_fs,''String'',[''fs = '' mat2str(fs)]), '...
             'if get(hc_data,''Value''), '...
             '   set (hc_fs,''Visible'',''off''), '...
             '   set (hc_N,''Visible'',''off''), '...
             'else, '...
             '   set (hc_fs,''Visible'',''on''), '...
             '   set (hc_N,''Visible'',''on''), '...
             'end, '...
             plotstr ];
hc_data = f_checkbox (data_source,pos(3,:),nt+1,1,nt+1,1,'Data source',colors(3,:),...
                      white,cbackdata,'Load x,y,fs. Set d = y',fsize);
if data_source
   set(hc_source,'Value',1)
end
hc_dB    = f_checkbox (dB,pos(4,:),nv+1,1,nv+1,1,'dB display',colors(3,:),white,plotstr,'Toggle dB display',fsize);

% Filter order slider             

dv = 0;
tipstr = 'Adjust filter order';
cback = [barstr plotstr];
hc_m = f_slider (m,m_min,m_max,pos(5,:),colors(2,:),'y',cback,tipstr,dv,'',fsize);

% Compute input signal

rand ('seed',1000)
eval(inputstr)

% Create plot

eval (plotstr)
 