
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
nodes(BST).E_initial = 3;
network = Prim(nodes);
fileID = fopen('dataPrim.tr', 'w');
timeStart = 1;
timeEnd = 7;
for timeStep = timeStart : timeEnd
%     try
        fprintf("%d\n", timeStep);
        for i = 2 : numNodes
            if ( nodes(i).E_initial > 1 )
                PrimPacketTransmission(i, BST, network);
            end
        end

        res_energy = energy_global_residual(nodes);
        cons_energy = 2*numNodes - res_energy;
        fprintf(fileID, '%d %d %d \n', timeStep, res_energy, cons_energy);
%     catch
%         res_energy = energy_global_residual(nodes);
%         cons_energy = 2*numNodes - res_energy;
%         fprintf(fileID, '%d %d %d \n', timeStep, res_energy, cons_energy);
%         fclose(fileID);
%         break;
%     end
end
