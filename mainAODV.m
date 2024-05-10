%% Create Animation Area
%Create(1);
title('AODV Routing');
%% Making Network
% Read x and y data from the MATLAB workspace
x = evalin('base', 'x');
y = evalin('base', 'y');
R = 15; % Radius in range of sensor Nodes
numNodes = length(x);
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
    nodes(i).critical_level = 0.5; 
end


%% Graph
[s, t] = Neighbor(nodes);
% G = graph(s, t);
% plot(G, 'XData', x, 'YData', y);
% plot_energy_info(nodes, handles.axes1);

 %% Simulation
%Add aodv routing protocol, use when node i want to send packets to BST
BST = 1;
nodes(BST).E_initial = 10;
network = AODV(nodes);
fileID = fopen('Trace/dataAODV.tr', 'w');
timeStart = 1;
timeEnd = 100;
global_E_initial = energy_global_residual(nodes);
for timeStep = timeStart : timeEnd
     fprintf("%d\n", timeStep);
    for i = 2 : numNodes
        if ( nodes(i).status == 0)
            PacketTransmission(i, BST, network);
        end
    end    
    
    res_energy = energy_global_residual(nodes);
    cons_energy = global_E_initial - res_energy;
    fprintf(fileID, '%d %d %d \n', timeStep, res_energy, cons_energy);
    if (nodes(BST).status == 1)
        break;
    end
end
