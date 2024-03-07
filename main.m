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
    nodes(i) = Node(x(i), y(i));
    nodes(i).radious = R;
end

[s, t] = Neighbor(nodes);

 %% Graph    
G = digraph(s, t);
linkEdge =  GetLinkEdge(nodes);
figure = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', linkEdge);

%% Prim_global
MST_global = Prim(1, length(nodes), nodes);

 %% Simulation
timeStart = 1;
timeEnd = 100;

for timeStep = timeStart : timeEnd    
    for i = 1 : length(nodes)      
        nodes(i).d0 = sqrt(nodes(i).Efs/nodes(i).Emp);
        for j = 1 : length(nodes(i).neighbor)
            nodes(i).change_energy_Tx;
        end     
        nodes(i).change_energy_Rx;
    end
    
    Parent(MST_global, nodes);

    clf;
    figure = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', linkEdge);
    figure.NodeColor = 'r';
    
    
    %% Show Energy
    ShowEnergy(x,y,nodes);     
    grid on;
    
    %% Transmission
    sensorNode = 10;
    Packet_transmission(sensorNode, nodes); 
    
    deadNode = 4;
    DisconnectedNode(nodes, deadNode);
    pause(0.1);    
end



 


