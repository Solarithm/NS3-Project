%% Create Animation Area
Create(1);

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


 %% Simulation
% Add dsdv routing protocol, routing table is created when start networking
network = DSDV(nodes);
init_DSDV_routing(network);
timeStart = 1;
timeEnd = 100;
BST = 1;
for timeStep = timeStart : timeEnd
    PacketTransmission(10, BST, network);
    PacketTransmission(12, BST, network);
    PacketTransmission(15, BST, network);   
end
