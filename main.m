%%
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
n = 15; 
R = 11; % Radius in range of sensor Nodes

x = [-5,3,4,7,12,12,17,22,27,33,31,35,37,46,51];
y = [20,23,18,21,27,12,17,28,21,25,26,24,26,26,30];
    
nodes = Node.empty(n, 0);
for i = 1 : n
    nodes(i) = Node(x(i), y(i));
end
s = [];
t = [];

%% Simulation
timeStart = 1;
timeEnd = 100;
clf;
for timeStep = timeStart : timeEnd

    [s, t] = Neighbor(nodes);
    Distance(nodes);
    %% Graph    
    G = digraph(s, t);
    linkEdge =  GetLinkEdge(nodes);
    figure = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', linkEdge);
    figure.NodeColor = 'r';
    
    %% Add energy 
    Energy(x,y,nodes);

    %% Prim_local
    MST_local = Prim(1, 13, nodes);
    for i = 1 : size(MST_local, 1)
        x1 = x(MST_local(i, 1));
        y1 = y(MST_local(i, 1));
        x2 = x(MST_local(i, 2));
        y2 = y(MST_local(i, 2));
        h = line([x1, x2], [y1, y2]);
        h.LineStyle = '-';
        h.LineWidth = 2;
        h.Color = [0 1 0];
    end
    pause(0.1);
end




 


