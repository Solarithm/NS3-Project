function varargout = GUI(varargin)
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
    global F;
    F = handles.axes1;
    hold on;
    handles.output = hObject;
    xlabel(handles.axes1, 'X Axis');
    ylabel(handles.axes1, 'Y Axis');
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
    
%     % Check if x and y exist in the base workspace
%     if evalin('base', 'exist(''x'', ''var'')') && evalin('base', 'exist(''y'', ''var'')')
%         % Retrieve x and y from the base workspace only if they are not already in handles
%         if ~isfield(handles, 'x') || isempty(handles.x)
%             handles.x = evalin('base', 'x');
%         end
%         
%         if ~isfield(handles, 'y') || isempty(handles.y)
%             handles.y = evalin('base', 'y');
%         end
%     end
    
    % Output handles structure with x and y arrays
    varargout{2} = handles.x;
    varargout{3} = handles.y;


% --- Executes on button press in create_button.
function create_button_Callback(hObject, eventdata, handles)
    nPacks = str2double(get(handles.packet_box, 'String'));
    assignin('base', 'numPacks', nPacks);

    R = str2double(get(handles.radious_edittext, 'String'));
    assignin('base', 'R', R);
    
    E_initial = str2double(get(handles.energy_edit, 'String'));
    assignin('base', 'E_initial', E_initial);

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

    x_base(end+1) = sx;
    y_base(end+1) = sy;
    R = str2double(get(handles.radious_edittext, 'String'));
    if seq_num == 1
        viscircles(handles.axes1, [sx, sy], 2, 'Color', '#7E2F8E', 'LineWidth', 2);
    else
        viscircles(handles.axes1, [sx, sy], 2, 'Color', 'g', 'LineWidth', 2);
    end
    % Display sequence number next to the node
    text(sx-0.8, sy+0.2, num2str(seq_num), 'Color', 'k', 'FontSize', 10, 'FontWeight', 'bold');

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
            if distance <= R
                plot(handles.axes1, [x_base(i), x_base(j)], [y_base(i), y_base(j)], 'blue'); % Blue line
            end
        end
    end

    hold(handles.axes1, 'off');







% --- Executes on button press in aodv_box.
function aodv_box_Callback(hObject, eventdata, handles)

% --- Executes on button press in eaodv_box.
function eaodv_box_Callback(hObject, eventdata, handles)

% --- Executes on button press in dsdv_box.
function dsdv_box_Callback(hObject, eventdata, handles)

% --- Executes on button press in edsdv_box.
function edsdv_box_Callback(hObject, eventdata, handles)

% --- Executes on button press in Start_button.
function Start_button_Callback(hObject, eventdata, handles)
    global critical_level; % Declare critical_level as a global variable
    critical_level = 0;
    if get(handles.aodv_box, 'Value') == 1
        critical_level = 0.001;
        mainAODV;
    elseif get(handles.eaodv_box, 'Value') == 1
        critical_level = 0.001;
        mainEAODV;
    elseif get(handles.dsdv_box, 'Value') == 1
        critical_level = 0.001;
        mainDSDV;
    elseif get(handles.edsdv_box, 'Value') == 1
        critical_level = 0.001;
        mainEDSDV;
    end

    main_axes_handle = gca;
    copyobj(allchild(main_axes_handle), handles.axes1);




function des_box_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function des_box_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function packet_box_Callback(hObject, eventdata, handles)
    

% --- Executes during object creation, after setting all properties.
function packet_box_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function radious_edittext_Callback(hObject, eventdata, handles)
    


% --- Executes during object creation, after setting all properties.
function radious_edittext_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
    cla(handles.axes1);
    
function reset_all_Callback(hObject, eventdata, handles)
    % Clear all graphics objects on map_axes
    cla(handles.axes1);
    evalin('base', 'clear all');

    % reset_all width and height edit boxes
    set(handles.edit1, 'String', '100');
    set(handles.edit2, 'String', '100');

    % Set mapCreated to false
    global mapCreated;
    mapCreated = true;



function energy_edit_Callback(hObject, eventdata, handles)
% hObject    handle to energy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of energy_edit as text
%        str2double(get(hObject,'String')) returns contents of energy_edit as a double


% --- Executes during object creation, after setting all properties.
function energy_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to energy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
