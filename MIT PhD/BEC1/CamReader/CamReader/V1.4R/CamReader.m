function varargout = CamReader(varargin)
% CAMREADER MATLAB code for CamReader.fig
%      CAMREADER, by itself, creates a new CAMREADER or raises the existing
%      singleton*.
%
%      H = CAMREADER returns the handle to a new CAMREADER or the handle to
%      the existing singleton*.
%
%      CAMREADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMREADER.M with the given input arguments.
%
%      CAMREADER('Property','Value',...) creates a new CAMREADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CamReader_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CamReader_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CamReader

% Last Modified by GUIDE v2.5 09-Nov-2015 18:14:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CamReader_OpeningFcn, ...
                   'gui_OutputFcn',  @CamReader_OutputFcn, ...
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


% --- Executes just before CamReader is made visible.
function CamReader_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CamReader (see VARARGIN)

% Choose default command line output for CamReader
handles.output = hObject;

MonthString = datestr(now,'yyyy-mm');
DateString = datestr(now,'yyyy-mm-dd');
handles.outfolder=['C:\',MonthString,'\',DateString];
set(handles.OutFolder,'String',handles.outfolder);

ex=exist(handles.outfolder,'dir');
if (ex~=7)
    mkdir(handles.outfolder);
end

%set up the input infolder
handles.infolder='C:\data\Side imaging';
set(handles.InFolder,'String',handles.infolder);

handles.list={};
handles.listshow={};
blank=zeros(64);
handles.img=image('Parent',handles.axes1,'CData',blank);

%initialize the image space in GUI


handles.scanning=false;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CamReader wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CamReader_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Imagelist.
function Imagelist_Callback(hObject, eventdata, handles)
% hObject    handle to Imagelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Imagelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Imagelist

var1=get(handles.Imagelist,'value');
var2=get(handles.Framelist,'value');
imgname=get(handles.Imagelist,'String');
img=fitsreadRL(handles.list{var1});
num=var2-1;
% img=fitsread([handles.outfolder,'\',imgname{var1}]);
% if num==0
%     frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
% else
%     if num==4
%         frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
%     else
%         frame=img(:,:,num);
%     end
% end

if num==0
    frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
    if get(handles.AutoScaleRaw,'value')
        set(handles.Custom,'value',1);
    end
else
    if num==4
        frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        if get(handles.AutoScaleRaw,'value')
            set(handles.Custom,'value',1);
        end
    else
        if (num==1)||(num==2)||(num==3)
            frame=img(:,:,num);
            if get(handles.AutoScaleRaw,'value')
                set(handles.Rescale,'value',1);
            end
        else
            set(handles.Imagelist,'value',1);
            frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        end
    end
end

set(handles.NameTag,'String',handles.listshow{var1});
showimage(frame,handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Imagelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Imagelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Scan.
function Scan_Callback(hObject, eventdata, handles)
% hObject    handle to Scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Scanning,'value',not(get(handles.Scanning,'value')));
guidata(hObject,handles);
while get(handles.Scanning,'value')
    NewFileList=dir([handles.infolder,'\*.fits']);
    N=size(NewFileList,1);
    newnamelist={};
    newnamelistshow={};
    pause(0.2);
    for i=1:N
        temp=NewFileList(i);
        newnamelist=[[handles.outfolder,'\',temp.name],newnamelist];
        newnamelistshow=[temp.name,newnamelistshow];
        movefile([handles.infolder,'\',temp.name],[handles.outfolder,'\',temp.name])
    end
    handles.list=[newnamelist,handles.list];
    handles.listshow=[newnamelistshow,handles.listshow];
    if N>0
        var2=get(handles.Framelist,'value');
        imgname=handles.list{1};
        num=var2-1;
        img=fitsreadRL(imgname);
        if num==0
            frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
            if get(handles.AutoScaleRaw,'value')
                set(handles.Custom,'value',1);
            end
        else
            if num==4
                frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
                if get(handles.AutoScaleRaw,'value')
                    set(handles.Custom,'value',1);
                end
            else
                if (num==1)||(num==2)||(num==3)
                    frame=img(:,:,num);
                    if get(handles.AutoScaleRaw,'value')
                        set(handles.Rescale,'value',1);
                    end
                else
                    set(handles.Imagelist,'value',1);
                    frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
                end
            end
        end
        set(handles.NameTag,'String',imgname);
        showimage(frame,handles);
    end
    set(handles.Imagelist,'String',handles.listshow);
    guidata(hObject,handles);
    pause(0.1);
end
guidata(hObject,handles);


% --- Executes on selection change in Framelist.
function Framelist_Callback(hObject, eventdata, handles)
% hObject    handle to Framelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Framelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Framelist
% var1=get(handles.Imagelist,'value');
% var2=get(handles.Framelist,'value');
% imgname=get(handles.Imagelist,'String');
% num=var2-1;
% img=fitsread([handles.outfolder,'\',imgname{var1}]);
% if num==0
%     frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
% else
%     if num==4
%         frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
%     else
%         frame=img(:,:,num);
%     end
% end
% set(handles.NameTag,'String',imgname{var1});
% showimage(frame,handles);
% guidata(hObject,handles);

var1=get(handles.Imagelist,'value');
var2=get(handles.Framelist,'value');
imgname=get(handles.Imagelist,'String');
img=fitsreadRL(handles.list{var1});
num=var2-1;
% img=fitsread([handles.outfolder,'\',imgname{var1}]);
% if num==0
%     frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
% else
%     if num==4
%         frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
%     else
%         frame=img(:,:,num);
%     end
% end

if num==0
    frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
    if get(handles.AutoScaleRaw,'value')
        set(handles.Custom,'value',1);
    end
else
    if num==4
        frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        if get(handles.AutoScaleRaw,'value')
            set(handles.Custom,'value',1);
        end
    else
        if (num==1)||(num==2)||(num==3)
            frame=img(:,:,num);
            if get(handles.AutoScaleRaw,'value')
                set(handles.Rescale,'value',1);
            end
        else
            set(handles.Imagelist,'value',1);
            frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        end
    end
end

set(handles.NameTag,'String',imgname{var1});
showimage(frame,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Framelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Framelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NHInp_Callback(hObject, eventdata, handles)
% hObject    handle to NHInp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NHInp as text
%        str2double(get(hObject,'String')) returns contents of NHInp as a double


% --- Executes during object creation, after setting all properties.
function NHInp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NHInp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NameHead.
function NameHead_Callback(hObject, eventdata, handles)
% hObject    handle to NameHead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.namehead=get(handles.NHInp,'String');
set(handles.NHDisp,'String',handles.namehead);
guidata(hObject,handles);

% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.InFolder,'String',folder_name);
handles.infolder=folder_name;
guidata(hObject, handles);


% --- Executes on button press in Scanning.
function Scanning_Callback(hObject, eventdata, handles)
% hObject    handle to Scanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Scanning



function Min_Callback(hObject, eventdata, handles)
% hObject    handle to Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Min as text
%        str2double(get(hObject,'String')) returns contents of Min as a double


% --- Executes during object creation, after setting all properties.
function Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Callback(hObject, eventdata, handles)
% hObject    handle to Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max as text
%        str2double(get(hObject,'String')) returns contents of Max as a double


% --- Executes during object creation, after setting all properties.
function Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Autosave.
function Autosave_Callback(hObject, eventdata, handles)
% hObject    handle to Autosave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Autosave


% --- Executes on button press in OutBrowse.
function OutBrowse_Callback(hObject, eventdata, handles)
outdir=uigetdir;
handles.outfolder=outdir;
set(handles.OutFolder,'String',handles.outfolder);
guidata(hObject, handles);
% hObject    handle to OutBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function NameTag_Callback(hObject, eventdata, handles)
% hObject    handle to NameTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NameTag as text
%        str2double(get(hObject,'String')) returns contents of NameTag as a double


% --- Executes during object creation, after setting all properties.
function NameTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NameTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AutoScaleRaw.
function AutoScaleRaw_Callback(hObject, eventdata, handles)
% hObject    handle to AutoScaleRaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AutoScaleRaw


% --- Executes on button press in Custom.
function Custom_Callback(hObject, eventdata, handles)
% hObject    handle to Custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Custom
