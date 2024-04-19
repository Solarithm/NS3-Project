
%% Create Animation Area
Create(2);
title('PRIM Routing');
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
 
%Add aodv routing protocol, use when node i want to send packets to BST
BST = 1;
network = Prim(nodes);
fileID = fopen('dataPrim.tr', 'w');
timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd
    try
        fprintf("%d\n", timeStep);
        PrimPacketTransmission(10, BST, network);
        PrimPacketTransmission(7, BST, network);  

        res_energy = energy_global_residual(nodes);
        fprintf(fileID, '%d %d \n', timeStep, res_energy);
    catch
        res_energy = energy_global_residual(nodes);
        fprintf(fileID, '%d %d \n', timeStep, res_energy);
        fclose(fileID);
        break;
    end
end
