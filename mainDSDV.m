%% Create Animation Area
Create(1);
title('DSDV Routing');
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
BST = 1;
nodes(BST).E_initial = 5;
timeStart = 1;
timeEnd = 100;
fileID = fopen('dataDSDV.tr', 'w');
for timeStep = timeStart : 39
    fprintf("%d\n", timeStep);
    if ( nodes(10).E_initial > 1 )
        PacketTransmission(10, BST, network);
    end
    if ( nodes(7).E_initial > 1 )
        PacketTransmission(7, BST, network);  
    end
    if ( nodes(35).E_initial > 1 )
        PacketTransmission(35, BST, network);  
    end
    if ( nodes(36).E_initial > 1 )
        PacketTransmission(36, BST, network);  
    end
    if ( nodes(20).E_initial > 1 )
        PacketTransmission(20, BST, network);  
    end
    if ( nodes(39).E_initial > 1 )
        PacketTransmission(39, BST, network);  
    end
    if ( nodes(15).E_initial > 1 )
        PacketTransmission(15, BST, network);  
    end
    
    res_energy = energy_global_residual(nodes);
    cons_energy = 2*numNodes - res_energy;
    fprintf(fileID, '%d %d %d \n', timeStep, res_energy+0.1, cons_energy-0.1);
end
