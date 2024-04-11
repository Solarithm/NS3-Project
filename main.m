%%
cla;
clf;
clc;
clear;
grid on
figure(1) % Hold figure 1
hold on
box on
xlabel (' Length (m)') % X-label of the output plot
ylabel (' Width (m)') % Y-label of the output plot
title (' Simulator') % Title of the plot

%% Making Network
numNodes = 15; 
R = 11; % Radius in range of sensor Nodes
x = [-5,3,4,7,12,12,17,22,27,33,31,35,37,46,51];
y = [20,23,18,21,27,12,17,28,21,25,26,24,26,26,30];   
nodes = Node.empty(numNodes, 0);
for i = 1 : numNodes
    nodes(i) = Node(i, x(i), y(i), R);
end


%% Graph
[s, t] = Neighbor(nodes);
G = digraph(s, t);
figure = plot(G, 'XData', x, 'YData', y);
ShowEnergy(nodes);

 %% Simulation
% %Add aodv routing protocol
% network = AODV(nodes);
% BST = 1;
% for i = 1 : numNodes
%     if i ~= BST
%         route_discovery(network, i, BST);
%     end
% end
%Add dsdv routing protocol
network = DSDV(nodes);
for i = 1 : numNodes
    for j = 1 : numNodes
        if i ~= j
            route_discovery(network, i, j);
        end
    end
end
display_routing_table(network, 2);
display_routing_table(network, 5);
timeStart = 1;
timeEnd = 100;
for timeStep = timeStart : timeEnd    
    for i = 1 : numNodes     
        nodes(i).d0 = sqrt(nodes(i).Efs/nodes(i).Emp);
        for j = 1 : length(nodes(i).neighbor)
            nodes(i).change_energy_Tx;
        end     
        nodes(i).change_energy_Rx;
    end
    
    

   
    pause(0.1);    
end



 

