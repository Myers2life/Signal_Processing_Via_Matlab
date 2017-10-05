function varargout = rest_GUI(varargin)
% REST_GUI MATLAB code for rest_GUI.fig
%      REST_GUI, by itself, creates a new REST_GUI or raises the existing
%      singleton*.
%
%      H = REST_GUI returns the handle to a new REST_GUI or the handle to
%      the existing singleton*.
%
%      REST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REST_GUI.M with the given input arguments.
%
%      REST_GUI('Property','Value',...) creates a new REST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rest_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rest_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rest_GUI

% Last Modified by GUIDE v2.5 18-Oct-2013 08:42:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rest_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @rest_GUI_OutputFcn, ...
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


% --- Executes just before rest_GUI is made visible.
function rest_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rest_GUI (see VARARGIN)

% Choose default command line output for rest_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rest_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rest_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs=8000;           %取样频率
duration=6;         %录音时间
%duration*fs 是总的采样点数
wavwrite(wavrecord(duration*fs,fs),'xh.wav')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
