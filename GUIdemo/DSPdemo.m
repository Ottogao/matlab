function varargout = DSPdemo(varargin)
% DSPDEMO M-file for DSPdemo.fig
%      DSPDEMO, by itself, creates a new DSPDEMO or raises the existing
%      singleton*.
%
%      H = DSPDEMO returns the handle to a new DSPDEMO or the handle to
%      the existing singleton*.
%
%      DSPDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSPDEMO.M with the given input arguments.
%
%      DSPDEMO('Property','Value',...) creates a new DSPDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DSPdemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DSPdemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DSPdemo

% Last Modified by GUIDE v2.5 04-May-2011 09:30:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @DSPdemo_OpeningFcn, ...
    'gui_OutputFcn',  @DSPdemo_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DSPdemo is made visible.
function DSPdemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DSPdemo (see VARARGIN)

% Choose default command line output for DSPdemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global RECORD_AUDIO PB_AUDIO        % declare global variables
set(handles.FilterOptions,'Enable','off');
set(handles.Input_Freq1,'Enable','off');
set(handles.Input_Freq2,'Enable','off');
set(handles.Process_button,'Enable','off');
set(handles.Playback_button,'Enable','off');
set(handles.SliderPitch, 'Enable', 'off');
set(handles.SliderPitch,'value',0.5);
set(handles.FilterOptions,'Value',1);

% UIWAIT makes DSPdemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSPdemo_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record_button.
function record_button_Callback(hObject, eventdata, handles)
% hObject    handle to record_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RECORD_AUDIO
h = warndlg('Clicking OK will record 5 sec audio','Warning');
uiwait(h);

h = waitbar(0,'Recording....');
steps=5;
RECORD_AUDIO = [];
recObj = audiorecorder(8000,16,1);
% for step=1:steps
%     recordblocking(recObj,1)  %vdata = wavrecord(8000, 8000, 1);
%     vdata = getaudiodata(recObj);
%     RECORD_AUDIO = [RECORD_AUDIO vdata'];
%     waitbar(step/steps);
% end
recordblocking(recObj,5);
RECORD_AUDIO = getaudiodata(recObj);
close(h);
% RECORD_AUDIO = wavrecord(5*8000,8000,1);
% h = warndlg('Recording is over.','Warning');
% uiwait(h)

axes(handles.InputAudio);
x=(1:length(RECORD_AUDIO))/8000;
plot(x,RECORD_AUDIO);
xlabel('sec.');
title('Input Audio in Time');

axes(handles.FFT_input);
inputFFTdata = zeros(8000,1);
for k=1:5
    chunk = RECORD_AUDIO((1+(k-1)*8000):k*8000);
    inputFFTdata = inputFFTdata + fft(chunk);
end
x=1:4000;
plot(x, abs(inputFFTdata(1:4000))/5);
xlabel('Hz');
title('Input Audio Spectrum')

axes(handles.Input_SPG);
L=256;
levels=12;
rectangle=0;
[G,f,t]=f_specgram(RECORD_AUDIO,L,8000,rectangle);
contour(f(1:L/2),t,G(:,1:L/2),levels);
xlabel('Hz');
ylabel('Time(sec)')
title('Input Audio Spectrogram');

set(handles.FilterOptions,'Enable','on');
set(handles.Input_Freq1,'Enable','on');
set(handles.Process_button,'Enable','on');


% --- Executes on button press in Reset_button.
function Reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to Reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RECORD_AUDIO PB_AUDIO;
RECORD_AUDIO = [];
PB_AUDIO = [];
cla(handles.InputAudio,'reset')
cla(handles.FFT_input,'reset')
cla(handles.OutputAudio,'reset');
cla(handles.FFT_output,'reset');
cla(handles.Input_SPG,'reset');
cla(handles.Output_SPG,'reset');
set(handles.FilterOptions,'Enable','off');
set(handles.Input_Freq1,'Enable','off');
set(handles.Input_Freq2,'Enable','off');
set(handles.Process_button,'Enable','off');
set(handles.Playback_button,'Enable','off');
set(handles.SliderPitch, 'Enable', 'off');
set(handles.SliderPitch,'value',0.5);
set(handles.FilterOptions,'value',1);

% --- Executes on selection change in FilterOptions.
function FilterOptions_Callback(hObject, eventdata, handles)
% hObject    handle to FilterOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FilterOptions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FilterOptions
val = get(hObject,'Value');
if(val == 1)
    set(handles.Input_Freq2, 'Enable', 'off');
    set(handles.Input_Freq1, 'Enable', 'on');
end
if(val == 2)
    set(handles.Input_Freq2, 'Enable', 'on');
    set(handles.Input_Freq1, 'Enable', 'off');
end

if(val == 3 || val == 4)
    set(handles.Input_Freq1, 'Enable', 'on');
    set(handles.Input_Freq2, 'Enable', 'on');
end

if(val == 5)    % vocal pitch shift
    set(handles.Input_Freq1, 'Enable', 'off');
    set(handles.Input_Freq2, 'Enable', 'off');
    set(handles.SliderPitch, 'Enable', 'on');
    set(handles.SliderPitch,'value',0.5);
end

% --- Executes during object creation, after setting all properties.
function FilterOptions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilterOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Input_Freq1_Callback(hObject, eventdata, handles)
% hObject    handle to Input_Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Input_Freq1 as text
%        str2double(get(hObject,'String')) returns contents of Input_Freq1 as a double


% --- Executes during object creation, after setting all properties.
function Input_Freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Input_Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Input_Freq2_Callback(hObject, eventdata, handles)
% hObject    handle to Input_Freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
% Hints: get(hObject,'String') returns contents of Input_Freq2 as text
%        str2double(get(hObject,'String')) returns contents of Input_Freq2 as a double


% --- Executes during object creation, after setting all properties.
function Input_Freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Input_Freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Process_button.
function Process_button_Callback(hObject, eventdata, handles)
% hObject    handle to Process_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RECORD_AUDIO PB_AUDIO;
fval = get(handles.FilterOptions,'Value');
if fval == 1    % lowpass filter
    f1 = get(handles.Input_Freq1,'String');
    f1 = str2num(f1);
    lpt = fir1(100, f1/4000);
    PB_AUDIO = filter(lpt,1,RECORD_AUDIO);
end

if fval == 2    % hipass filter
    f1 = get(handles.Input_Freq2,'String');
    f1 = str2num(f1);
    hpt = fir1(100, f1/4000, 'high');
    PB_AUDIO = filter(hpt,1,RECORD_AUDIO);
end

if fval == 3    % bandpass filter
    f1 = get(handles.Input_Freq1,'String');
    f2 = get(handles.Input_Freq2,'String');
    f1 = str2num(f1);
    f2 = str2num(f2);
    if(f1>=f2)
        temp = f1;
        f1 = f2;
        f2 = temp;
    end
    bpt = fir1(100, [f1 f2]/4000, 'bandpass');
    PB_AUDIO = filter(bpt,1,RECORD_AUDIO);
end

if fval == 4    % bandstop filter
    f1 = get(handles.Input_Freq1,'String');
    f2 = get(handles.Input_Freq2,'String');
    f1 = str2num(f1);
    f2 = str2num(f2);
    if(f1>=f2)
        temp = f1;
        f1 = f2;
        f2 = temp;
    end
    bpt = fir1(100, [f1 f2]/4000, 'stop');
    PB_AUDIO = filter(bpt,1,RECORD_AUDIO);    
end

if fval == 5    % vocoder, making voice more girly
    shiftVal = get(handles.SliderPitch,'value')+0.5; % value in range of [0.5,1.5]
    shiftVal = round(shiftVal*10);      % re-scale value to be integer
    result = pvoc(RECORD_AUDIO, shiftVal/10, 1024);
    PB_AUDIO = resample(result', shiftVal, 10);
    if(length(PB_AUDIO)>=40000)
        PB_AUDIO = PB_AUDIO(1:40000);
    else
        PB_AUDIO = [PB_AUDIO zeros(1,40000-length(PB_AUDIO))];
    end
end

if fval <1 || fval>5    % if wrong option is chosen, copy the input to output
    PB_AUDIO = RECORD_AUDIO;
end

axes(handles.OutputAudio);
x=(1:length(PB_AUDIO))/8000;
plot(x,PB_AUDIO);
xlabel('sec.');
title('Output Audio in Time');

axes(handles.FFT_output);
outputFFTdata = zeros(8000,1);
for k=1:5
    outputFFTdata = outputFFTdata + fft(PB_AUDIO((1+(k-1)*8000):k*8000));
end
x=1:4000;
plot(x, abs(outputFFTdata(1:4000))/5);
xlabel('Hz');
title('Output Audio Spectrum')

axes(handles.Output_SPG);
L=256;
levels=12;
rectangle=0;
[G,f,t]=f_specgram(PB_AUDIO,L,8000,rectangle);
contour(f(1:L/2),t,G(:,1:L/2),levels);
xlabel('Hz');
ylabel('Time(sec)')
title('Output Audio Spectrogram');

% the last thing to do is to activate the Playback button
set(handles.Playback_button,'Enable','on');


% --- Executes on button press in Playback_button.
function Playback_button_Callback(hObject, eventdata, handles)
% hObject    handle to Playback_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PB_AUDIO
if(~isempty(PB_AUDIO))
    sound(PB_AUDIO,8000);
end


% --- Executes on slider movement.
function SliderPitch_Callback(hObject, eventdata, handles)
% hObject    handle to SliderPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SliderPitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


