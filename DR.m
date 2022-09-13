function varargout = DR(varargin)
% DR MATLAB code for DR.fig
%      DR, by itself, creates a new DR or raises the existing
%      singleton*.
%
%      H = DR returns the handle to a new DR or the handle to
%      the existing singleton*.
%
%      DR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DR.M with the given input arguments.
%
%      DR('Property','Value',...) creates a new DR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DR

% Last Modified by GUIDE v2.5 14-Mar-2018 23:44:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DR_OpeningFcn, ...
                   'gui_OutputFcn',  @DR_OutputFcn, ...
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


% --- Executes just before DR is made visible.
function DR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DR (see VARARGIN)

% Choose default command line output for DR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_image_button.
function select_image_button_Callback(hObject, eventdata, handles)
% hObject    handle to select_image_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global input_img h
input_img=Browse_image_func();
axes(handles.axes1);
imshow(input_img);
title('Original Image');

% --- Executes on button press in preprocess_button.
function preprocess_button_Callback(hObject, eventdata, handles)
% hObject    handle to preprocess_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%preprocessing..........
global input_img pre_img od_img img1 BW BW2 CA final_img n_od h
pre_img=preprocess_func(input_img);
axes(handles.axes2);
imshow(pre_img);
title('Preprocessed Image');



% --- Executes on button press in OD_detection.
function OD_detection_Callback(hObject, eventdata, handles)
% hObject    handle to OD_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%optic disc detection.............
global input_img pre_img od_img delete_od_img 
od_img=ODdetection_func(pre_img);
axes(handles.axes3);
imshow(od_img);
title('OD detection');
numWhitePixels = nnz(od_img);
%[r,c]= size(od_img);
%for i=1:r
    %for j=1:c
        %if(od_img(i,j)~=1)
            %flag =1;
       % end
    %end
%end
  %if(numWhitePixels==0)
     %delete_od_img = delete_od_func_new(od_img,input_img);
 %else
      delete_od_img = delete_od_func(od_img,input_img); 
  %end
 


% --- Executes on button press in MA_detection.
function MA_detection_Callback(hObject, eventdata, handles)
% hObject    handle to MA_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%MA detection.............
global input_img pre_img od_img MA_img delete_od_img BW BW2 CA final_img n_od h MA_area
[MA_img,MA_area]=MA_new_func( input_img );
%MA_area = MA_detection_func( input_img );
axes(handles.axes4);
imshow(MA_img);
title('MA detection');


% --- Executes on button press in OD_detection.
function Hemmarage_detection_button_Callback(hObject, eventdata, handles)
% hObject    handle to OD_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%MA detection.............
global input_img vessel_img HM_img HM_area
[HM_img,HM_area] = HM_detection_func( input_img );
axes(handles.axes5);
imshow(HM_img);
title('HM detection');
%vessel_img = vessel_detection_func(input_img );



% --- Executes on button press in Exudate_detection_button.
function Exudate_detection_button_Callback(hObject, eventdata, handles)
% hObject    handle to Exudate_detection_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global input_img pre_img od_img MA_img delete_od_img exudate_img vessel_area exudate_area MA_area vessel_img HM_area
[exudate_img,exudate_area ]=exudate_func( delete_od_img,input_img );
axes(handles.axes6);
imshow(exudate_img);
title('Exudate detection');

fis = readfis('fuzzy_demo');
                    out = evalfis([MA_area HM_area exudate_area],fis);
                    disp(out);
                    if out < .25
                       helpdlg('Mild');
                    
                    elseif out >=.25 && out<= .5
                       helpdlg('Moderate');  
                       
                    
                    
                     else 
                        helpdlg('Severe');
                     end
                  
               