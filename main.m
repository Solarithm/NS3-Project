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
MST_global = Prim(1, 15, nodes);
for i = 1 : size(MST_global,1)
    x1 = x(MST_global(i, 1));
    y1 = y(MST_global(i, 1));
    x2 = x(MST_global(i, 2));
    y2 = y(MST_global(i, 2));
    h = line([x1, x2], [y1, y2]);
    h.LineStyle = '-';
    h.LineWidth = 2;
    h.Color = [0 1 0];
    pause(0.2);
end

 %% Simulation
timeStart = 1;
timeEnd = 100;
clf;
for timeStep = timeStart : timeEnd
    
    for i = 1 : length(nodes)      
        nodes(i).d0 = sqrt(nodes(i).Efs/nodes(i).Emp);
        for j = 1 : length(nodes(i).neighbor)
            nodes(i).change_energy_Tx;
        end     
        nodes(i).change_energy_Rx;
    end
    
    Parent(MST_global, nodes);
    
    figure = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', linkEdge);
    figure.NodeColor = 'r';
    
    %% Show Energy
    ShowEnergy(x,y,nodes);     
    grid on;
    sensorNode = 10;
    
    %% Transmission
    [px, py] = Packet_transmission(sensorNode, nodes); 
    for i = 1 : length(px) - 1
        x1 = px(i);
        y1 = py(i);
        x2 = px(i+1);
        y2 = py(i+1);
        h = line([x1, x2], [y1, y2]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 0 1];
        pause(0.5);        
        drawnow;
    end  
    deadNode = 4;
    DisconnectedNode(nodes, deadNode);
    pause(0.1);    
end



 


