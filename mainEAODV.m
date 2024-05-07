%% Create Animation Area
Create(1);
title('EAODV Routing');
%% Making Network

R = 15; % Radius in range of sensor Nodes
[x, y, numNodes] = coordinate();
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
end


%% Graph
[s, t] = Neighbor(nodes);
G = graph(s, t);


 %% Simulation
 
%Add aodv routing protocol, use when node i want to send packets to BST
BST = 1;
nodes(BST).E_initial = 10;
network = EAODV(nodes);
fileID = fopen('dataEAODV.tr', 'w');
timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd
     fprintf("%d\n", timeStep);
    for i = 2 : numNodes
        if ( nodes(i).E_initial > 1 )
            PacketTransmission(i, BST, network);
        end
    end
     
    res_energy = energy_global_residual(nodes);
    cons_energy = 2*numNodes - res_energy;
    fprintf(fileID, '%d %d %d \n', timeStep, res_energy, cons_energy);
end
figure = plot(G, 'XData', x, 'YData', y);
plot_energy_info(nodes);