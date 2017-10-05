function varargout = GUI_sume(varargin)
% GUI_SUME MATLAB code for GUI_sume.fig
%      GUI_SUME, by itself, creates a new GUI_SUME or raises the existing
%      singleton*.
%
%      H = GUI_SUME returns the handle to a new GUI_SUME or the handle to
%      the existing singleton*.
%
%      GUI_SUME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SUME.M with the given input arguments.
%
%      GUI_SUME('Property','Value',...) creates a new GUI_SUME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_sume_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_sume_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_sume

% Last Modified by GUIDE v2.5 18-Oct-2013 08:53:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_sume_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_sume_OutputFcn, ...
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


% --- Executes just before GUI_sume is made visible.
function GUI_sume_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_sume (see VARARGIN)

% Choose default command line output for GUI_sume
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_sume wait for user response (see UIRESUME)
% uiwait(handles.filter_character);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_sume_OutputFcn(hObject, eventdata, handles) 
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
wavwrite(wavrecord(duration*fs,fs),'xiong.wav')


% --- Executes on button press in play.
function y=play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y,Fs]=wavread('xiong.wav');
wavplay(y,Fs);


% --- Executes on button press in filter.
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b=[ 0.0011    0.0021    0.0011];
a=[ 1.0000   -1.9056    0.9099];
%b,a为滤波器系数，设计标准参见filter_for_lastone
[y,Fs]=wavread('xiong.wav');
y_f=filter(b,a,y);
wavwrite(y_f,'xiong_f.wav');
%其实录完直接滤波就比较合适
%要不在滤波之前先按了波音将读不到文件而出错

% --- Executes on button press in filter_character.
function filter_character_Callback(hObject, eventdata, handles)
% hObject    handle to filter_character (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b=[ 0.0011    0.0021    0.0011];
a=[ 1.0000   -1.9056    0.9099];
[db,mag,pha,grd,w]=freqz_m(b,a);
axes(handles.axes1);
plot([1:500]/500,db);title('幅度响应');
ylabel('decibels');grid on;xlabel('frequency in pi units');
axis([0 0.1 -30 1]);
% > %滤波器指标
% wp=0.01*pi;
% ws=0.05*pi;
% Rp=1;
% As=15;
% %模拟滤波器指标
% T=1/FFSS;
% OmegaP=(2/T)*tan(wp/2)
% OmegaS=(2/T)*tan(ws/2)
% 
% OmegaP =
% 
%   251.3481
% 
% 
% OmegaS =
% 
%    1.2592e+03


% --- Executes on button press in Voice_time.
function Voice_time_Callback(hObject, eventdata, handles)
% hObject    handle to Voice_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
[y,Fs]=wavread('xiong.wav');
[y_f,Fs_y]=wavread('xiong_f.wav');
plot(y)
hold on;
plot(y_f,'r')
hold off;



% --- Executes on button press in voice_fre.
function voice_fre_Callback(hObject, eventdata, handles)
% hObject    handle to voice_fre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
[y,Fs]=wavread('xiong.wav');
[y_f,Fs_y]=wavread('xiong_f.wav');
stem(abs(fftshift(fft(y))));
hold on;
stem(abs(fftshift(fft(y_f))),'r');

% --- Executes on button press in play_y_f.
function play_y_f_Callback(hObject, eventdata, handles)
% hObject    handle to play_y_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y_f,Fs_y]=wavread('xiong_f.wav');
wavplay(y_f,Fs_y);


% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y,Fs]=wavread('xiong.wav');
y=0.01*cosdemo2(2000,size(y),1/8000)'+y;
y=0.01*cosdemo2(3900,size(y),1/8000)'+y;
wavwrite(y,'xiong.wav');