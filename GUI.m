function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 10-May-2024 12:24:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)
% Choose default command line output for GUI
global F;
F = handles.axes1;
hold on;
handles.output = hObject;
global mapCreated;
mapCreated = true;
evalin('base', 'clear all');
if ~isfield(handles, 'x') || isempty(handles.x)
        % Initialize x and y if they are not already initialized
        handles.x = [];
        handles.y = [];
end
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
    
    % Check if x and y exist in the base workspace
    if evalin('base', 'exist(''x'', ''var'')') && evalin('base', 'exist(''y'', ''var'')')
        % Retrieve x and y from the base workspace only if they are not already in handles
        if ~isfield(handles, 'x') || isempty(handles.x)
            handles.x = evalin('base', 'x');
        end
        
        if ~isfield(handles, 'y') || isempty(handles.y)
            handles.y = evalin('base', 'ystaa');
        end
    end
    
    % Output handles structure with x and y arrays
    varargout{2} = handles.x;
    varargout{3} = handles.y;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% width = str2double(get(handles.edit1, 'String'));
% height = str2double(get(handles.edit2, 'String'));
% % Create a blank figure for the map
% cla(handles.axes1);
% axis(handles.axes1, [0 width 0 height]);
% xlabel(handles.axes1, 'Width');
% ylabel(handles.axes1, 'Height');
% title(handles.axes1, 'Click to place network nodes');
% set(handles.axes1, 'ButtonDownFcn', {@axes1_ButtonDownFcn, handles});
% % Set mapCreated to true
% global mapCreated;
% mapCreated = true;

function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global mapCreated;
if ~mapCreated
    return; % Exit function if map not created yet
end


function axes1_ButtonDownFcn(hObject, eventdata, handles)
    global mapCreated;
    if ~mapCreated
        return; % Exit function if map not created yet
    end

    currentPoint = get(handles.axes1, 'CurrentPoint');
    sx = currentPoint(1, 1);
    sy = currentPoint(1, 2);

    % Plot a marker at the clicked point
    hold(handles.axes1, 'on');
    viscircles(handles.axes1, [sx, sy], 2, 'Color', 'g', 'LineWidth', 2);

    % Retrieve the existing variables from the base workspace
    if evalin('base', 'exist(''x'', ''var'')') && evalin('base', 'exist(''y'', ''var'')')
        x_base = evalin('base', 'x');
        y_base = evalin('base', 'y');
        seq_num = evalin('base', 'seq_num');
    else
        % If the variables don't exist, initialize them as empty arrays
        x_base = [];
        y_base = [];
        seq_num = 0;
    end

    % Increment sequence number
    seq_num = seq_num + 1;

    % Append new node data to the existing arrays
    x_base(end+1) = sx;
    y_base(end+1) = sy;
    
    % Create a new Node object
    new_node = Node(seq_num, sx, sy, 15); % You need to define 'radius' or pass it as an argument
    % Display sequence number next to the node
    text(sx-0.2, sy-0.2, num2str(seq_num), 'Color', 'k', 'FontSize', 10);

    % Update x, y, and seq_num in the base workspace
    assignin('base', 'x', x_base);
    assignin('base', 'y', y_base);
    assignin('base', 'seq_num', seq_num);

    % Draw lines between nodes within a certain range
    for i = 1:numel(x_base)
        for j = (i+1):numel(x_base)
            dx = x_base(i) - x_base(j);
            dy = y_base(i) - y_base(j);
            distance = sqrt(dx^2 + dy^2);
            if distance <= 15
                plot(handles.axes1, [x_base(i), x_base(j)], [y_base(i), y_base(j)], 'black'); % Blue line
            end
        end
    end

    hold(handles.axes1, 'off');



% --- Executes on button press in reset.
% --- Executes on button press in reset_button.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Clear all graphics objects on map_axes
cla(handles.axes1);
evalin('base', 'clear all');

% Reset width and height edit boxes
set(handles.edit1, 'String', '');
set(handles.edit2, 'String', '');

% Set mapCreated to false
global mapCreated;
mapCreated = true;




% --- Executes on button press in aodv_box.
function aodv_box_Callback(hObject, eventdata, handles)
% hObject    handle to aodv_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of aodv_box


% --- Executes on button press in eaodv_box.
function eaodv_box_Callback(hObject, eventdata, handles)
% hObject    handle to eaodv_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eaodv_box


% --- Executes on button press in dsdvbox.
function dsdvbox_Callback(hObject, eventdata, handles)
% hObject    handle to dsdvbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dsdvbox


% --- Executes on button press in edsdv_box.
function edsdv_box_Callback(hObject, eventdata, handles)
% hObject    handle to edsdv_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of edsdv_box



% --- Executes on button press in Start_button.
function Start_button_Callback(hObject, eventdata, handles)
   if get(handles.aodv_box, 'Value') == 1
        mainAODV;
    elseif get(handles.eaodv_box, 'Value') == 1
        mainEAODV;
    end
    
    % Get the handle to the axes in the figure generated by mainAODV
    main_axes_handle = gca;
    
    % Copy the content of the axes from mainAODV to the axes in your GUI
    copyobj(allchild(main_axes_handle), handles.axes1);



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function packet_box_Callback(hObject, eventdata, handles)
% hObject    handle to packet_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of packet_box as text
%        str2double(get(hObject,'String')) returns contents of packet_box as a double


% --- Executes during object creation, after setting all properties.
function packet_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to packet_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
