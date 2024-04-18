%% Create Animation Area
Create();

%% Making Network

R = 11; % Radius in range of sensor Nodes
[x, y, numNodes] = coordinate();
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
end


%% Graph
[s, t] = Neighbor(nodes);
G = graph(s, t);
figure = plot(G, 'XData', x, 'YData', y);
plot_energy_info(nodes);

%% TEMP
index1 = [];
E1 = [];
 %% Simulation
 
%Add aodv routing protocol, use when node i want to send packets to BST
BST = 1;
network = AODV(nodes);
fileID = fopen('dataAODV.tr', 'w');
timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd
    
    PacketTransmission(10, BST, network);
    PacketTransmission(7, BST, network);  
    
    
    res_energy = energy_global_residual(nodes);
    fprintf(fileID, '%d %d \n', timeStep, res_energy);
end
