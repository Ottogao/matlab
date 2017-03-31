function varargout = demoGUIWaitbar(varargin)
%DEMOGUIWAITBAR M-file for demoGUIWaitbar.fig
%      DEMOGUIWAITBAR, by itself, creates a new DEMOGUIWAITBAR or raises the existing
%      singleton*.
%
%      H = DEMOGUIWAITBAR returns the handle to a new DEMOGUIWAITBAR or the handle to
%      the existing singleton*.
%
%      DEMOGUIWAITBAR('Property','Value',...) creates a new DEMOGUIWAITBAR using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to demoGUIWaitbar_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      DEMOGUIWAITBAR('CALLBACK') and DEMOGUIWAITBAR('CALLBACK',hObject,...) call the
%      local function named CALLBACK in DEMOGUIWAITBAR.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demoGUIWaitbar

% Last Modified by GUIDE v2.5 05-Mar-2008 21:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demoGUIWaitbar_OpeningFcn, ...
                   'gui_OutputFcn',  @demoGUIWaitbar_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before demoGUIWaitbar is made visible.
function demoGUIWaitbar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for demoGUIWaitbar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demoGUIWaitbar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demoGUIWaitbar_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
h=handles.axis_waitbar;
axes(h)
axis off;
handles.howfast=0.5;  % Default pause time of button
set(handles.slider_howfast,'Value',0.5);
set(handles.text_howfast,'String',num2str(0.5));
guidata(hObject, handles);

% --- Executes on button press in pushbutton_stopMe.
function pushbutton_stopMe_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stopMe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

persistent stopme
handles.t0=clock;   % to record starting time

n=100;             % total number of button movement

% Domain of the button movement (pixels)
xlim =[6 333];
ylim =[6 303];
width = 131;
height = 47;

buttonCaption = get(handles.pushbutton_stopMe,'String');

% Check if the button is clicked when it started to move
% Note that the initial caption of the button is 'Click me' 
if strcmp(buttonCaption,'Stop me')
	stopme = true;
	return;
else
	stopme=false;
end

% Change caption after first clicking the 'Click me' button
set(handles.pushbutton_stopMe,'String','Stop me')
guidata(hObject, handles);

%% Loop starts here
nhit_left=0;
nhit_right=0;
for i=1:n
	 
	 if ~stopme   
         % if Stop me button has been clicked then stop the movement of the button
		 % random position of the button in the domain of figure
         x = xlim(1)+ (xlim(2)-xlim(1)).*rand(1,1); 
		 y = ylim(1)+ (ylim(2)-ylim(1)).*rand(1,1);
		 pos = [x y width height];
		 if ~ishandle(handles.pushbutton_stopMe);return;end; 
		 set(handles.pushbutton_stopMe,'Units','Pixels','Position',pos)
         
         % Count number of hits in the left or right panel
         if x > xlim(2)/2
             nhit_right=nhit_right+1;
             set(handles.text_right,'String',num2str(nhit_right))
         else
             nhit_left=nhit_left+1;
             set(handles.text_left,'String',num2str(nhit_left))
         end
		 % Pause the button for time defined by the slider in seconds
         pause(handles.howfast)
         
         % Update the progress bar
		 update_waitbar(handles,i/n)
     else
         % If successed to click the 'Stop me button then stop the movement
         % of the button and gives the score
         score = getscore(i,handles.howfast);
         msg{1}='Congratulation!!! You catched me...';
         msg{2} = ['Your score is: ' num2str(score) ' (100 is best, 0 is worst)'];
		 msgbox(msg) 
		 set(handles.pushbutton_stopMe,'String','Click me again')
		 stopme = false;
		 break;end;
end
% Clear variables to start again
set(handles.pushbutton_stopMe,'String','Click me again')
clear all


% --- Executes on slider movement.
function slider_howfast_Callback(hObject, eventdata, handles)
% hObject    handle to slider_howfast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 val = get(hObject,'Value');
 handles.howfast =val;
 set(handles.text_howfast,'String',num2str(val));
 guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_howfast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_howfast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% Internal Function
function update_waitbar(handles,value)
% Update waitbar
h=handles.axis_waitbar;
if ~ishandle(h);return;end;
set(h,'Visible','On');
axes(h);
cla;
patch([0,value,value,0],[0,0,1,1],'b');
axis([0,1,0,1]);
axis off;
%% Other information
set(handles.percent_text,'String',strcat(num2str(floor(value*100)),'%'));
time_lapse = etime(clock,handles.t0);
if value~=0
    time_eta=(time_lapse/value)*(1-value);
else return; end;
time_lapse = round(time_lapse);
time_eta=round(time_eta);
str_lapse= get_timestr(time_lapse);
str_eta= get_timestr(time_eta);
set(handles.elapsObj,'String',['Elapsed Time: ' str_lapse]);
set(handles.etaObj,'String',['Estimated Time Remaining: ' str_eta]);
set(handles.jobObj,'String',['Job Started: ' datestr(handles.t0)]);
drawnow;

%% 
function timestr= get_timestr(s) 
% Return a time string, given seconds.

h = floor(s/3600);					% Hours.
s = s - h*3600;
m = floor(s/60);						% Minutes.
s = s - m*60;							% Seconds.
timestr = sprintf('%0d:%02d:%02d', h, m, floor(s));

%%
function score = getscore(nattempts,speed)
% GETSCROE returns the score of your speed to hit the target i.e. clicking
% the moving button
% Score is defined by 1/(nattempts*speed) and normalised to 0 and 100
% 0 is the lowest score when the speed is 5 seconds and nattempts is 100.
% Score will be 100 when hit the button at first attempt at the speed of
% the movement is 0.5 seconds.
%%
maxscore = 1/(1*0.5);
minscore = 1/(5*100);
score = 1/(nattempts*speed);
score = 100*(1-(maxscore-score)./(maxscore-minscore));

