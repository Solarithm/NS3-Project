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
G = graph(s, t);
figure = plot(G, 'XData', x, 'YData', y);
plot_energy_info(nodes);

 %% Simulation
%Add aodv routing protocol, use when node i want to send packets to BST
BST = 1;
network = AODV(nodes);

%Add dsdv routing protocol, routing table is created when start networking
% network = DSDV(nodes);
% init_DSDV_routing(network);
timeStart = 1;
timeEnd = 100;

for timeStep = timeStart : timeEnd
    
    PacketTransmission(10, BST, network);
    plot_energy_info(nodes);
    
    pause(0.1);    
end



 

