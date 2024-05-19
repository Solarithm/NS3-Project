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
E_initial = evalin('base', 'E_initial');
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
    nodes(i).nPackets = numPacks;
    if i ~= 1
        nodes(i).E_initial = E_initial;
    end  
    nodes(i).critical_level = critical_level;
end

%% Graph
[s, t] = Neighbor(nodes);
% G = graph(s, t);
% figure = plot(G, 'XData', x, 'YData', y);
% plot_energy_info(nodes);

%% Parameter
global_E_initial = energy_global_residual(nodes);
send_pack = 0;
rec_pack = 0;
 %% Simulation
% Add dsdv routing protocol, routing table is created when start networking
network = DSDV(nodes);
init_DSDV_routing(network);
BST = 1;
nodes(BST).E_initial = 10;
timeStart = 1;
timeEnd = 1000;
fileID = fopen('dataDSDV.tr', 'w');
for timeStep = timeStart : timeEnd
    fprintf("Time %d\n", timeStep);
    for i = 2 : numNodes
        if nodes(i).status == 0 && isPath(nodes, i, BST) == 1
            packs = PacketTransmission(i, BST, network);
            rec_pack = rec_pack + packs;
            send_pack = send_pack + 1;
        else
            nodes(i).status = 1;
        end
    end    
    res_energy = energy_global_residual(nodes);
    cons_energy = global_E_initial - res_energy;
    
    if (nodes(BST).status == 1)
        break;
    end
end
fprintf('Done');
fprintf(fileID, '%d %d %d %d %d %d\n', timeStep, count_critical(nodes),send_pack, rec_pack, cons_energy, rec_pack/send_pack*100);
