%% Create Animation Area
%Create(1);
title('Simulation');
%% Making Network
% Read x and y data from the MATLAB workspace
x = evalin('base', 'x');
y = evalin('base', 'y');
R = evalin('base', 'R'); % Radius in range of sensor Nodes
global critical_level;
numNodes = length(x);
numPacks = evalin('base', 'numPacks');
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
    nodes(i).nPackets = numPacks;
    nodes(i).E_initial = 0.03;
    nodes(i).critical_level = critical_level;
end


%% Graph
[s, t] = Neighbor(nodes);
% G = graph(s, t);
% plot(G, 'XData', x, 'YData', y);
% plot_energy_info(nodes, handles.axes1);

paths = OptimizePath(nodes, 10, 1);